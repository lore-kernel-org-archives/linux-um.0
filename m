Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AG1WF-00008q-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 01 Nov 2003 11:34:43 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AG1WE-0007Oy-Lv
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 01 Nov 2003 11:34:42 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EJTo/+6OxHXUby0"
Message-Id: <200310301646.12168.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Uml crash with segfault on idle
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 30 Oct 2003 16:46:12 +0100
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_EJTo/+6OxHXUby0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Two times I got an UML crashing when I left it active on my box. The first 
time I didn't report it since I wasn't able to get backtraces(i.e. no 
debugging info) and it was a patched version.

Now I've left 2.4.22-5um running and idle(with two consoles open): the UML had 
been started, then I Ctrl+z it and bg'ed it(and it worked fine). But now 
those consoles are open but I can't type anything(as previous time). There 
are only 3 threads(the fourth is died: the shell under which I ran it 
reported a segmentation fault about it) and I've got with gdb) their 
backtraces(they seem to be good: I've used gdb 6.0).
This was the command line:
  ./linux umid=slack90 ubd0=slack90.rootfs root=/dev/ubd0 ubd7=slack90.swapfs 
mem=64m eth0=tuntap,,,192.168.0.1 UML_XDISPLAY=192.168.0.1:0 
UML_IP=192.168.0.3 dsp=/dev/dsp mixer=/dev/mixer con=xterm con0=fd:3 
3<>uml-slack90-log

They are currently all in S state.

I'm attaching backtraces, the content of uml-slack90 and the startup output.

The host is a 2.4.22-ck2 + skas(ck2 patchset is from Con Kolivas, it's O(1) + 
preemptible + low latency backports basically, very stable and no conflicts).

I'm willing to help: I can gdb it and set breakpoints, to get the point of 
failure, if you say me how (Or better, set a trap for SIGSEGV probably, if 
you say me the exact "handle" syntax for this, since the shell reported a 
segfault). What do you need to investigate on this? 

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_EJTo/+6OxHXUby0
Content-Type: text/plain;
  charset="us-ascii";
  name="bug-report"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="bug-report"

----First backtrace:

#0  0xa0152e31 in poll () at /usr/src/linuxUm-2.4.22/include/asm/pgtable.h:257
#1  0x00000001 in ?? ()
#2  0xa3d1dfc7 in ?? ()
#3  0xa3d1dff0 in ?? ()
(gdb wasn't able to decode those, but those, really, are just data saved on the stack: I checked the function disassembly)
#4  0xa009af74 in write_sigio_thread (unused=Cannot access memory at address 0x9
) at sigio_user.c:186
Previous frame inner to this frame (corrupt stack?)

----Then, I checked by hand(with disassembles and stack inspection) and saw that the "unused" param. of write_sigio_thread was NULL as expected, and that the calling function was clone, at the "call ebx"(or in att flavour "call   *%ebx") line, as expected.

----Then I got this:
(gdb) attach 18097
Attaching to program: /home/paolo/Uml/linux, process 18097
0xa014fe00 in pause () at /usr/src/linuxUm-2.4.22/include/asm/pgtable.h:257
257     {
(gdb) where
#0  0xa014fe00 in pause () at /usr/src/linuxUm-2.4.22/include/asm/pgtable.h:257
#1  0xa00de47d in winch_thread (arg=0x2) at chan_user.c:140
#2  0xa0153627 in clone () at /usr/src/linuxUm-2.4.22/include/asm/pgtable.h:257
(gdb) detach
Detaching from program: /home/paolo/Uml/linux, process 18097

-----And this:

(gdb) attach 18351
Attaching to program: /home/paolo/Uml/linux, process 18351
0xa014fe00 in pause () at /usr/src/linuxUm-2.4.22/include/asm/pgtable.h:257
257     {
(gdb) where
#0  0xa014fe00 in pause () at /usr/src/linuxUm-2.4.22/include/asm/pgtable.h:257
#1  0xa00de47d in winch_thread (arg=0x2) at chan_user.c:140
#2  0xa0153627 in clone () at /usr/src/linuxUm-2.4.22/include/asm/pgtable.h:257

----Those references to pgtable.h are to the inline function pte_write.

----Then startup output:

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Linux version 2.4.22-5um (root@blaisorblade) (gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)) #5 ven ott 17 12:21:34 CEST 2003
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: umid=slack90 ubd0=slack90.rootfs root=/dev/ubd0 ubd7=slack90.swapfs mem=64m eth0=tuntap,,,192.168.0.1 UML_XDISPLAY=192.168.0.1:0 UML_IP=192.168.0.3 dsp=/dev/dsp mixer=/dev/mixer con=xterm con0=fd:3
Calibrating delay loop... 693.61 BogoMIPS
Memory: 61296k available
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Initializing software serial port version 1
mconsole (version 2) initialized on /home/paolo/.uml/slack90/mconsole
Partition check:
 ubda: unknown partition table
 ubdh: unknown partition table
ubd : Synchronous mode
UML Audio Relay (host dsp = /dev/dsp, host mixer = /dev/mixer)
Initializing stdio console driver

---Then, check in the uml-slack90-log file I've attached. Almost all was present since the
startup, but the last line. I don't know if it's just a buffer being flushed or if that means
anything.

--Boundary-00=_EJTo/+6OxHXUby0
Content-Type: text/plain;
  charset="us-ascii";
  name="uml-slack90-log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="uml-slack90-log"

TmV0ZGV2aWNlIDAgOiBUVU4vVEFQIGJhY2tlbmQgLSBJUCA9IDE5Mi4xNjguMC4xCk5FVDQ6IExp
bnV4IFRDUC9JUCAxLjAgZm9yIE5FVDQuMApJUCBQcm90b2NvbHM6IElDTVAsIFVEUCwgVENQLCBJ
R01QCklQOiByb3V0aW5nIGNhY2hlIGhhc2ggdGFibGUgb2YgNTEyIGJ1Y2tldHMsIDRLYnl0ZXMK
VENQOiBIYXNoIHRhYmxlcyBjb25maWd1cmVkIChlc3RhYmxpc2hlZCA0MDk2IGJpbmQgODE5MikK
TkVUNDogVW5peCBkb21haW4gc29ja2V0cyAxLjAvU01QIGZvciBMaW51eCBORVQ0LjAuCmtqb3Vy
bmFsZCBzdGFydGluZy4gIENvbW1pdCBpbnRlcnZhbCA1IHNlY29uZHMKRVhUMy1mczogbW91bnRl
ZCBmaWxlc3lzdGVtIHdpdGggb3JkZXJlZCBkYXRhIG1vZGUuClZGUzogTW91bnRlZCByb290IChl
eHQzIGZpbGVzeXN0ZW0pIHJlYWRvbmx5LgoNSU5JVDogdmVyc2lvbiAyLjg0IGJvb3RpbmcNDQpB
ZGRpbmcgU3dhcDogMTMxMDY0ayBzd2FwLXNwYWNlIChwcmlvcml0eSAtMSkKL2V0Yy9yYy5kL3Jj
LlM6IGxpbmUgMjM6IFRlc3RpbmcgZmlsZXN5c3RlbSBzdGF0dXM6IFJlYWQtb25seSBmaWxlIHN5
c3RlbQ0KQ2hlY2tpbmcgcm9vdCBmaWxlc3lzdGVtOg0KZnNjayAxLjMyICgwOS1Ob3YtMjAwMikN
Ci9kZXYvdWJkYTogY2xlYW4sIDM5MzY0LzEzMTA3MiBmaWxlcywgNDMyMjY2LzUyNDI4OCBibG9j
a3MNClJlbW91bnRpbmcgcm9vdCBkZXZpY2Ugd2l0aCByZWFkLXdyaXRlIGVuYWJsZWQuDQpFWFQz
IEZTIDIuNC0wLjkuMTksIDE5IEF1Z3VzdCAyMDAyIG9uIHViZCg5OCwwKSwgaW50ZXJuYWwgam91
cm5hbAovZGV2L3ViZGEgb24gLyB0eXBlIGV4dDMgKHJ3KQ0KQ2hlY2tpbmcgbm9uLXJvb3QgZmls
ZXN5c3RlbXM6DQpmc2NrIDEuMzIgKDA5LU5vdi0yMDAyKQ0KZGV2cHRzIG9uIC9kZXYvcHRzIHR5
cGUgZGV2cHRzIChydyxnaWQ9NSxtb2RlPTYyMCkNCnByb2Mgb24gL3Byb2MgdHlwZSBwcm9jIChy
dykNCmhvc3Qgb24gL21udC9ob3N0IHR5cGUgaG9zdGZzIChydywvKQ0KU2V0dGluZyBzeXN0ZW0g
dGltZSBmcm9tIHRoZSBoYXJkd2FyZSBjbG9jayAobG9jYWx0aW1lKS4NCm1vZHByb2JlOiBtb2Rw
cm9iZTogQ2FuJ3QgbG9jYXRlIG1vZHVsZSBjaGFyLW1ham9yLTEwLTEzNQ0NCjEAAjIAADMAADQA
ADUAADYAADcAADgAADkA/jdwMQACMgAAMwAANAAANQAANgAANwAAOAAAOQD+OHAxAAIyAAAzAAA0
AAA1AAA2AAA3AAA4AAA5AP45cDEAAjIAADMAADQAADUAADYAADcAADgAADkA/DNkMHAxAAQyAAAz
AAA0AAA1AAA2AAA3AAA4AAA5AP4xcDEAAjIAADMAADQAADUAADYAADcAADgAADkA/jJwMQACMgAA
MwAANAAANQAANgAANwAAOAAAOQD+M3AxAAIyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP40cDEAAjIA
ADMAADQAADUAADYAADcAADgAADkA/jVwMQACMgAAMwAANAAANQAANgAANwAAOAAAOQD+NnAxAAIy
AAAzAAA0AAA1AAA2AAA3AAA4AAA5AP43cDEAAjIAADMAADQAADUAADYAADcAADgAADkA/jhwMQAC
MgAAMwAANAAANQAANgAANwAAOAAAOQD+OXAxAAIyAAAzAAA0AAA1AAA2AAA3AAA4AAA5APw0ZDBw
MQAEMgAAMwAANAAANQAANgAANwAAOAAAOQD+MXAxAAIyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP4y
cDEAAjIAADMAADQAADUAADYAADcAADgAADkA/jNwMQACMgAAMwAANAAANQAANgAANwAAOAAAOQD+
NHAxAAIyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP41cDEAAjIAADMAADQAADUAADYAADcAADgAADkA
/jZwMQACMgAAMwAANAAANQAANgAANwAAOAAAOQD+N3AxAAIyAAAzAAA0AAA1AAA2AAA3AAA4AAA5
AP44cDEAAjIAADMAADQAADUAADYAADcAADgAADkA/jlwMQACMgAAMwAANAAANQAANgAANwAAOAAA
OQD8NWQwcDEABDIAADMAADQAADUAADYAADcAADgAADkA/jFwMQACMgAAMwAANAAANQAANgAANwAA
OAAAOQD+MnAxAAIyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP4zcDEAAjIAADMAADQAADUAADYAADcA
ADgAADkA/jRwMQACMgAAMwAANAAANQAANgAANwAAOAAAOQD+NXAxAAIyAAAzAAA0AAA1AAA2AAA3
AAA4AAA5AP42cDEAAjIAADMAADQAADUAADYAADcAADgAADkA/jdwMQACMgAAMwAANAAANQAANgAA
NwAAOAAAOQD+OHAxAAIyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP45cDEAAjIAADMAADQAADUAADYA
ADcAADgAADkA/DZkMHAxAAQyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP4xcDEAAjIAADMAADQAADUA
ADYAADcAADgAADkA/jJwMQACMgAAMwAANAAANQAANgAANwAAOAAAOQD+M3AxAAIyAAAzAAA0AAA1
AAA2AAA3AAA4AAA5AP40cDEAAjIAADMAADQAADUAADYAADcAADgAADkA/jVwMQACMgAAMwAANAAA
NQAANgAANwAAOAAAOQD+NnAxAAIyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP43cDEAAjIAADMAADQA
ADUAADYAADcAADgAADkA/jhwMQACMgAAMwAANAAANQAANgAANwAAOAAAOQD+OXAxAAIyAAAzAAA0
AAA1AAA2AAA3AAA4AAA5APwyZDEwcDEwAAYxAAAyAAAzAAA0AAA1AP0xcDEwAAMxAAAyAAAzAAA0
AAA1AP0ycDEwAAMxAAAyAAAzAAA0AAA1AP0zcDEwAAMxAAAyAAAzAAA0AAA1AP00cDEwAAMxAAAy
AAAzAAA0AAA1AP01cDEwAAMxAAAyAAAzAAA0AAA1APo3ZDBwMQAEMgAAMwAANAAANQAANgAANwAA
OAAAOQD+MXAxAAIyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP4ycDEAAjIAADMAADQAADUAADYAADcA
ADgAADkA/jNwMQACMgAAMwAANAAANQAANgAANwAAOAAAOQD+NHAxAAIyAAAzAAA0AAA1AAA2AAA3
AAA4AAA5AP41cDEAAjIAADMAADQAADUAADYAADcAADgAADkA/jZwMQACMgAAMwAANAAANQAANgAA
NwAAOAAAOQD+N3AxAAIyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP44cDEAAjIAADMAADQAADUAADYA
ADcAADgAADkA/jlwMQACMgAAMwAANAAANQAANgAANwAAOAAAOQD8M2QxMHAxMAAGMQAAMgAAMwAA
NAAANQD9MXAxMAADMQAAMgAAMwAANAAANQD9MnAxMAADMQAAMgAAMwAANAAANQD9M3AxMAADMQAA
MgAAMwAANAAANQD9NHAxMAADMQAAMgAAMwAANAAANQD9NXAxMAADMQAAMgAAMwAANAAANQD6NGQx
MHAxMAAGMQAAMgAAMwAANAAANQD9MXAxMAADMQAAMgAAMwAANAAANQD9MnAxMAADMQAAMgAAMwAA
NAAANQD9M3AxMAADMQAAMgAAMwAANAAANQD9NHAxMAADMQAAMgAAMwAANAAANQD9NXAxMAADMQAA
MgAAMwAANAAANQD6NWQxMHAxMAAGMQAAMgAAMwAANAAANQD9MXAxMAADMQAAMgAAMwAANAAANQD9
MnAxMAADMQAAMgAAMwAANAAANQD9M3AxMAADMQAAMgAAMwAANAAANQD9NHAxMAADMQAAMgAAMwAA
NAAANQD9NXAxMAADMQAAMgAAMwAANAAANQD6NmQxMHAxMAAGMQAAMgAAMwAANAAANQD9MXAxMAAD
MQAAMgAAMwAANAAANQD9MnAxMAADMQAAMgAAMwAANAAANQD9M3AxMAADMQAAMgAAMwAANAAANQD9
NHAxMAADMQAAMgAAMwAANAAANQD9NXAxMAADMQAAMgAAMwAANAAANQD1aHQwAAIxAP5pcGwAAGpz
MAACMQAAMgAAMwD+bGNkAAFlZAD/bWQwAAIxAAAyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP5scDAA
AjEAADIAADMA/m1jZAAAbG9nAABtZW0AAG5iMAACMQAAMgAAMwAANAAANQAANgAANwAAOAAAOQD/
ZXQAAi90dW4A/XBmMAACMQAAMgAAMwD/ZzAAATEAADIAADMA/2RhAAFiAABjAABkAP9tdQAAdDAA
ATEAADIAADMAADQAADUAADYAADcAADgAADkA/3BwAAB0cwACLzAAATEAADIAADMAADQAADUAADYA
ADcAADgA/HJhbQACdwABL3JhdzEABDIAADMAADQAADUAADYAADcAADgAADkAADEwAAExAAAyAAAz
AAA0AAA1AAA2AAA3AAA4AAA5AP8yMAABMQAAMgAAMwAANAAANQAANgAANwAAOAAAOQD/MzAAATEA
ADIAADMAADQAADUAADYAADcAADgAADkA/zQwAAExAAAyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP81
MAABMQAAMgAAMwAANAAANQAANgAANwAAOAAAOQD/NjAAATEAADIAADMAADQAADUAADYAADcAADgA
ADkA/zcwAAExAAAyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP84MAABMQAAMgAAMwAANAAANQAANgAA
NwAAOAAAOQD/OTAAATEAADIAADMAADQAADUAADYAADcAADgAADkA/zEwMAACMQAAMgAAMwAANAAA
NQAANgAANwAAOAAAOQD/MTAAATEAADIAADMAADQAADUAADYAADcAADgAADkA/zIwAAExAAAyAAAz
AAA0AAA1AAA2AAA3AAA4AAA5AP8zMAABMQAAMgAAMwAANAAANQAANgAANwAAOAAAOQD/NDAAATEA
ADIAADMAADQAADUAADYAADcAADgAADkA/zUwAAExAAAyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP82
MAABMQAAMgAAMwAANAAANQAANgAANwAAOAAAOQD/NzAAATEAADIAADMAADQAADUAADYAADcAADgA
ADkA/zgwAAExAAAyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP85MAABMQAAMgAAMwAANAAANQAANgAA
NwAAOAAAOQD+MjAwAAIxAAAyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP8xMAABMQAAMgAAMwAANAAA
NQAANgAANwAAOAAAOQD/MjAAATEAADIAADMAADQAADUAADYAADcAADgAADkA/zMwAAExAAAyAAAz
AAA0AAA1AAA2AAA3AAA4AAA5AP80MAABMQAAMgAAMwAANAAANQAANgAANwAAOAAAOQD/NTAAATEA
ADIAADMAADQAADUA93FuZwAAc2cwAAIxAAAyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AP9kYQABYgAA
YwAAZAAAZQAAZgAAZwAAaAAAaQAAagAAawAAbAAAbQAAbgAAbwAAcAAAcQAAcgAAcwAAdAAAdQAA
dgAAdwAAeAAAeQAAegD/Z2EAAWIAAGMAAGQAAGUAAGYAAGcAAGgAAGkAAGoAAGsAAGwAAG0AAG4A
AG8AAHAA/2htAA==

--Boundary-00=_EJTo/+6OxHXUby0--




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
