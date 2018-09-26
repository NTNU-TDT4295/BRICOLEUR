
  #ifndef DRAMExample_H
  #define DRAMExample_H
  #include "wrapperregdriver.h"
  #include <map>
  #include <string>
  #include <vector>

  using namespace std;
  class DRAMExample {
  public:
    DRAMExample(WrapperRegDriver * platform) {
      m_platform = platform;
      attach();
    }
    ~DRAMExample() {
      detach();
    }

      void set_baseAddr(AccelDblReg value) { writeReg(1, (AccelReg)(value >> 32)); writeReg(2, (AccelReg)(value & 0xffffffff)); }
  void set_btn(AccelReg value) {writeReg(3, value);} 
  void set_byteCount(AccelReg value) {writeReg(4, value);} 
  AccelReg get_cycleCount() {return readReg(5);} 
  AccelReg get_finished() {return readReg(6);} 
  AccelReg get_led() {return readReg(7);} 
  AccelReg get_led4_0() {return readReg(8);} 
  AccelReg get_led4_1() {return readReg(9);} 
  AccelReg get_led4_2() {return readReg(10);} 
  AccelReg get_led5_0() {return readReg(11);} 
  AccelReg get_led5_1() {return readReg(12);} 
  AccelReg get_led5_2() {return readReg(13);} 
  AccelReg get_signature() {return readReg(0);} 
  void set_start(AccelReg value) {writeReg(14, value);} 
  AccelReg get_sum() {return readReg(15);} 
  void set_sw(AccelReg value) {writeReg(16, value);} 


    map<string, vector<unsigned int>> getStatusRegs() {
      map<string, vector<unsigned int>> ret = { {"cycleCount", {5}} ,  {"finished", {6}} ,  {"led", {7}} ,  {"led4_0", {8}} ,  {"led4_1", {9}} ,  {"led4_2", {10}} ,  {"led5_0", {11}} ,  {"led5_1", {12}} ,  {"led5_2", {13}} ,  {"signature", {0}} ,  {"sum", {15}} };
      return ret;
    }

    AccelReg readStatusReg(string regName) {
      map<string, vector<unsigned int>> statRegMap = getStatusRegs();
      if(statRegMap[regName].size() != 1) throw ">32 bit status regs are not yet supported from readStatusReg";
      return readReg(statRegMap[regName][0]);
    }

  protected:
    WrapperRegDriver * m_platform;
    AccelReg readReg(unsigned int i) {return m_platform->readReg(i);}
    void writeReg(unsigned int i, AccelReg v) {m_platform->writeReg(i,v);}
    void attach() {m_platform->attach("DRAMExample");}
    void detach() {m_platform->detach();}
  };
  #endif
      