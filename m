Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYvCo-00027K-BH for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 19:26:38 -0700
Received: from mx1.aist.go.jp ([150.29.246.133])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HYvCm-0007om-9v
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 19:26:38 -0700
Received: from rqsmtp2.aist.go.jp (rqsmtp2.aist.go.jp [150.29.254.123])
	by mx1.aist.go.jp  with ESMTP id l342QJgA002687
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 4 Apr 2007 11:26:22 +0900 (JST) env-from (k.suzaki@aist.go.jp)
Received: from smtp2.aist.go.jp
	by rqsmtp2.aist.go.jp  with ESMTP id l342QJU6012453
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 4 Apr 2007 11:26:19 +0900 (JST) env-from (k.suzaki@aist.go.jp)
Received: by smtp2.aist.go.jp  with ESMTP id l342QIZQ018468
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 4 Apr 2007 11:26:18 +0900 (JST) env-from (k.suzaki@aist.go.jp)
Date: Wed, 04 Apr 2007 11:50:40 +0900 (JST)
Message-Id: <20070404.115040.71085028.k.suzaki@aist.go.jp>
From: Kuniyasu Suzaki <k.suzaki@aist.go.jp>
Mime-Version: 1.0
Subject: [uml-devel] Release: VMKNOPPIX(20070328) with Trusted Boot
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net


Dear,

We released VMKNOPPIX(20070328) with Trusted Boot.
   http://unit.aist.go.jp/itri/knoppix/vmknoppix/index-en.html

VMKnoppix is a collection of Virtual Machine Software, Xen, KVM,
VirtualBox, QEMU, KQEMU(QEMU with Accelerator) and UserModeLinux.
This version includes "Trusted Boot" (Trusted GRUB and IMA: Integrity
Measured Architecture).

=== Features ======================================================================
VM Collection: Xen3.0.4-1(DomainU & HVM Domain), KVM16, VirtualBox,
               QEMU, KQEMU(QEMU with Accelerator) and UserModeLinux.
               There are many techniques of Virtual Machine, para-virtualization, 
               full-virtualization with virtualization instruction(IntelVT or AMD-V), 
               dynamic translation etc. The VM softwares runs with OS images offered 
               by some sites(For instance OSZoo's QEMU images).Have fun with the techniques!

Trusted Boot: Trusted GRUB and IMA(Integrity Measured Architecture) 
              on TPM(Trusted Platform Module)1.2.
              Caution: The BIOS must deal with Trusted Boot to enable this function. 
              Trusted GRUB: http://trousers.sourceforge.net/grub.html
              IMA: http://domino.research.ibm.com/comm/research_people.nsf/pages/sailer.ima.html
              ***Help us***: If you have vTPM on your virtual machine, please boot with 
                             this ISO image and report. If possible we want to integrate 
                             vTPM on our VMKnoppix and OS Circular.

OS Circular: VMKNOPPIX includes Internet Client "OS Circular" environment. 
             OS Circular enables to boot OSes on Xen with a globalized virtual 
             disk "HTTP-FUSE CLOOP". 

Benchmark: VMKNOPPIX includes benchmark softwares. 
           Pi calculation for CPU benchmark http://h2np.net/pi/pi_quick_start.tar.gz 
           dbench for IO benchmark 
           tbench for Network benchmark 
           Xengine for Graphic Benchmark 

OProfile: VMKNOPPIX includes xenoprifle to take profile of HVM Domain OS. 

Quick Boot: VMKNOPPIX is optimized by LCAT for fast CD boot. 

GRUB Menu: includes three items; Xen3.04-1(kernel 2.6.16.33), IMA(kerenel2.6.19.1) and 
           normal KNOPPIX (kernel 2.6.19). 

=== How to use Virtual Machine =========================================================
* Xen
Boot with the first option "KNOPPIX/Xen3.0.4-1" of GRUB.
To run DomainU with KNOPPPIX.
  # knoppixU

To run HVM Domain with KNOPPPIX on IntelVT or AMD-V.
  # knoppixHVM
  Caution) Add "nofirewire" kernel option at GRUB Menu for Intel MAC.

----------------
* OS Circular
Boot with the first option "KNOPPIX/Xen3.0.4-1" of GRUB on IntelVT or AMD-V.
 # pump -i eth0
 # /etc/inint.d/xend start
 # httpfuse-hvm.sh
Selection Menu will be appeared. Select a near site. 
Contents Menu will be appeared. Select your favorite image. 
The OS will be appeared. Current Debian Etch has accounts, "root/http-fuse" or 
"http-fuse/http-fuse". 
 Caution) Add "nofirewire" kernel option at GRUB Menu for Intel MAC.
 Caution) The console must be wider than 80x24to run httpfuse-hvm.sh, because 
          "dialog" requires wide console. If the console is small, the message 
          "httpstoraged is ready ..." will continue.

The technical detail was presented Virtualization Miniconf at LinuxConfAu07.
  http://virtminiconf.linux.hp.com/program/os-circulation-environment-201ctrusted-http-fuse-xenoppix201d
  Slide PDF http://unit.aist.go.jp/itri/knoppix/20070118-LCA-HTTP-FUSE.pdf

----------------
* VirtualBox
Boot with the third option "KNOPPIX(normal kernel)" on GRUB.
  # modprobe vboxdrv
  # VBoxSVC &
  # VirtualBox
After that, setup VM environment interactively. The CD-Drive is setup at the main 
menu after Interactive setup.

----------------
* kqemu/KVM/QEMU
Boot with the third option "KNOPPIX(normal kernel)" on GRUB.

Script "qemu-knoppix.sh" prepares network environment, shared memory for
KQEMU, and drivers for KVM or KQEMU.

The priority is as follows.
 1) If kvm drivers effective, kvm runs.
 2) If kqemu is effective, kqemu runs.
 3) If kvm and kqemu aren't available, qemu runs.

"qemu-knoppix.sh" aslo accepts the follwing options.
  -no-kvm   : disable KVM kernel module usage
  -no-kqemu : disable KQEMU kernel module usage
  -no-module: disable all kernel module usage

For examples, the following command runs kqemu.
 # qemu-knoppix.sh -no-kvm

----------------
* UML: UserModeLinux (2.6.18) 
Boot with the third option "KNOPPIX(normal kernel)" on GRUB.
 
Script "umlknx.sh" prepares the environment for UML.
 # umlknx.sh -no-kvm

=== How to use Trusted Boot =========================================================
Trusted GRUB and IMA(Integrity Measured Architecture) on TPM1.2 (Trusted Platform Module).
The devices, blocks and files, which are used at boot time, are measured 
and registered at PCRs(Platform Configuration Register) of the secure chip 
TPM (Trusted Platform Module).

Boot with the second option "KNOPPIX(2.6.19.1+ima)" on GRUB. 

At GRUB, we can check the TPM. Enter command line with "c". We can
check the status, the values of PCRs and the event log with following
commands. Enter "Esc" to exit the command line.

   grub> tpm
   grub> tpm pcrs
   grub> tpm eventlog
 
After the linux boots, we can check the measurement with the following commands. 

* Set up. 
   # mount -t securityfs none /sys/kernel/security 
* Show the event log of GRUB. 
   # cat /sys/kernel/security/tpm0/ascii_bios_measurements
* Show the event log of IMA. The list is the opened ELF files. When you
  open a new ELF file, the file name is logged.
   # cat /sys/kernel/security/ima/ascii_runtime_measurements
* Show the PCRs value. The values are changed when IMA extends a new value. 
   # cat /sys/devlice/pnp0/00:0b/pcrs

=== Benchmarks =====================================================================

* pi calculation
  # time /opt/pi_quick_start/pi 3000000

* dbench (Read /usr/share/dbench.client.txt)
 # dbench 1

* tbench (Read /usr/share/dbench.client.txt via network)
 On Host
  # tbench_srv
 On Guest
  # tbench -t 60 1 "HostIP. Example 10.0.2.2 on VirtualBox,KVM, KQEMU, QEMU"

* xengine
  # xengine

*** Benchmark Results (OLD)
* Pi calculation
           | sec   |Remarks
-----------+-------+-----
     Native| 14.67 | Core2 Duo T7200 
     kvm-14| 19.26 |
     kvm-12| 17.90 |(Sample. CD doesn't include)
qemu(kqemu)| 24.87 | "-kernel-kqemu" is not used
       qemu|227.1  | "-no-kqemu" 
 VirtualBox| 17.56 |
  Xen(DomU)| 14.68 |
   Xen(HVM)| 15.99 |
-----------+-------+-----

* dbench
           | MB/s  |Remarks
-----------+-------+-----
     Native| 341.0 | Core2 Duo T7200 
     kvm-14| 206.1 |
      kqemu|  36.20| "-kernel-kqemu" is not used
       qemu|  29.17| "-no-kqemu" 
 VirtualBox| 223.9 |
  Xen(DomU)| 283.1 |
   Xen(HVM)| 203.3 |
-----------+-------+-----

* tbehch between Host and Guest.
C2D: Core2 Duo T7200 (IBM ThinkPAD T60)
AMD: Athlon64x2 4000+
        |  C2D|Athlon| Remarks
        | MB/s|  MB/s| 
--------+-----+------+----------
vbox    | 1.72|  1.57|
kvm14   | 0.50|  1.05|
kvm12   | 1.05|  1.15|(Sample. CD doesn't include)
kqemu   | 1.46|  ====|
qemu    | 1.53|  1.37|
Xen DomU|67.8 | 74.7 |
Xen HVM | 4.11|  3.57|
--------+-----+------+

=== Oprofile =======================================================================
Run HVM Domain 
 # knoppixHVM
Select the first option "KNOPPIX/Xen3.0.4-1" on GRUB.

Run oprofile
 # opcontrol --start-daemon --vmlinux=/boot/vmlinux-syms-2.6.16.33-xen --xen=/boot/xen-syms-3.0.4-1 --passive-domains=1 --passive-images=/boot/vmlinux-syms-2.6.16.33-xen

Stopping profiling.
 # opcontrol --stop
Show the result.
 # opreport -l
----- The Result are following -----
The Result 
CPU: Core 2, speed 2327.56 MHz (estimated)
 Counted CPU_CLK_UNHALTED events (Clock cycles when not halted) with a unit maskof 0x00 (Unhalted core cycles) count 100000
 samples % app name symbol name
 15904 61.6625 qemu-dm (no symbols)
 1741 6.7502 libqt-mt.so.3.3.7 (no symbols)
 1432 5.5521 libshadow.so (no symbols)
 702 2.7218 domain1-modules (no symbols)
 649 2.5163 libc-2.3.6.so (no symbols)
 361 1.3997 bash (no symbols)
 283 1.0972 xen-syms-3.0.4-1 handle_exception
 216 0.8375 libfb.so (no symbols)
 133 0.5157 xen-syms-3.0.4-1 hypercall
 130 0.5040 ld-2.3.6.so (no symbols)
 128 0.4963 vmlinux-syms-2.6.16.33-xen hypercall_page
 124 0.4808 Xorg (no symbols)
 122 0.4730 python2.4 (no symbols)
 
=== Download =====================================================================
File name: knoppix_v5.1.1CD_20070104_xen3.0.4.1_vbox_ima-20070316+IPAFont_AC20070328.iso 
          MD5: 3bb97388162c1f6a4c4a2784f7808169 
FTP: ftp://unit.aist.go.jp/itri/knoppix/iso/knoppix_v5.1.1CD_20070104_xen3.0.4.1_vbox_ima-20070316+IPAFont_AC20070328.iso 
HTTP (Ring Servers): http://www.ring.gr.jp/archives/linux/knoppix/iso/ 
Bittorrent: knoppix_v5.1.1CD_20070104_xen3.0.4.1_vbox_ima-20070316+IPAFont_AC20070328.iso.torrent 

------
suzaki

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
