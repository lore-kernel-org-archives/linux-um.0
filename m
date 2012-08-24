Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 24 Aug 2012 19:19:02 +0300
Message-ID: <CAKiyQA_DFqAKWF2_wU52WURf5+8NkQecE4dqQLtn4VMcFT0G9w@mail.gmail.com>
From: Dragos Diaconescu <diaconescud@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2068204636006600278=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] SMP on UML
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

--===============2068204636006600278==
Content-Type: multipart/alternative; boundary=000e0ce005fe855dad04c80555b8

--000e0ce005fe855dad04c80555b8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello,

I try to compile the UML, from a linux kernel(make ARCH=3Dum SUBARCH=3Di386=
)
and I have configured it to use SMP (make config). I am getting the
following error:

  CHK     include/generated/utsrelease.h
  CC      arch/um/kernel/asm-offsets.s
In file included from include/linux/sched.h:77:0,
                 from
/home/dragos/work/linux-3.5.2/arch/x86/um/shared/sysdep/kernel-offsets.h:2,
                 from arch/um/kernel/asm-offsets.c:1:
include/linux/topology.h: In function =91numa_node_id=92:
include/linux/topology.h:217:9: error: =91current_thread=92 undeclared (fir=
st
use in this function)
include/linux/topology.h:217:9: note: each undeclared identifier is
reported only once for each function it appears in
include/linux/topology.h:217:9: warning: left-hand operand of comma
expression has no effect [-Wunused-value]
make[1]: *** [arch/um/kernel/asm-offsets.s] Error 1

Do you have any ideas?

Thanks,

Dragos

--000e0ce005fe855dad04c80555b8
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I try to compile the UML, from a linux kernel(make ARCH=3Dum =
SUBARCH=3Di386) <br>and I have configured it to use SMP (make config). I am=
 getting the following error:<br><br>=A0 CHK=A0=A0=A0=A0 include/generated/=
utsrelease.h<br>
=A0 CC=A0=A0=A0=A0=A0 arch/um/kernel/asm-offsets.s<br>In file included from=
 include/linux/sched.h:77:0,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 from /home/dragos/work/linux-3.5.2/arch/x86/um/shared/sysdep/kernel-=
offsets.h:2,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from arch/=
um/kernel/asm-offsets.c:1:<br>
include/linux/topology.h: In function =91numa_node_id=92:<br>include/linux/=
topology.h:217:9: error: =91current_thread=92 undeclared (first use in this=
 function)<br>include/linux/topology.h:217:9: note: each undeclared identif=
ier is reported only once for each function it appears in<br>
include/linux/topology.h:217:9: warning: left-hand operand of comma express=
ion has no effect [-Wunused-value]<br>make[1]: *** [arch/um/kernel/asm-offs=
ets.s] Error 1<br><br>Do you have any ideas?<br><br>Thanks,<br><br>Dragos<b=
r>
<br>

--000e0ce005fe855dad04c80555b8--


--===============2068204636006600278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============2068204636006600278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2068204636006600278==--


