#include <vector>
#include <thread>
#include <chrono>

#include <cstdint>
#include <cstring>

#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

#include <fmt/format.h>

static constexpr size_t mem_address = 0x43c0'0000;

int main(int argc, char *argv[]) {
	auto fd = open("/dev/mem", O_RDWR | O_SYNC);
	if(fd < 0) {
		std::printf("Error opening /dev/mem\n");
		close(fd);
		return 1;
	}
	const char * const mem = reinterpret_cast<decltype(mem)>(mmap(
		NULL,
		65536,
		PROT_READ | PROT_WRITE,
		MAP_SHARED,
		fd,
		mem_address
	));
	if(mem == MAP_FAILED) {
		std::printf("Error mapping /dev/mem\n");
		close(fd);
		return 1;
	}

	const uint16_t addr = strtoul(argv[1], nullptr, 16);
	uint32_t read_value;
	std::memcpy(&read_value, mem + addr, 4);
	fmt::print("{}: {:x}\n", addr, read_value);

	munmap(const_cast<char*>(mem), 65536);
	return 0;
}
