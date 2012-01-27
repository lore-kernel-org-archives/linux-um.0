Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <long21s@gmail.com>) id 1Rqd6B-0001tC-7a
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jan 2012 04:07:39 +0000
Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rqd6A-0001Le-7W
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jan 2012 04:07:39 +0000
Received: by bkaq10 with SMTP id q10so1549614bka.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 26 Jan 2012 20:07:31 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 27 Jan 2012 13:07:31 +0900
Message-ID: <CADBe2Pxk--RJHAp=FyAaeJkx+UO-+St=+J1sfyPn+DzVwyEhew@mail.gmail.com>
From: SeongHan Seo <long21s@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5897239196174206736=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] rw semaphore lost wakeup in x86_64
To: user-mode-linux-devel@lists.sourceforge.net
Cc: sangho1206.park@samsung.com, allsky@gmail.com

--===============5897239196174206736==
Content-Type: multipart/alternative; boundary=001517592f1cc91a7f04b77aa248

--001517592f1cc91a7f04b77aa248
Content-Type: text/plain; charset=ISO-8859-1

Hi

My name is Sunghan Suh and I'm a software engineer for a software company
in South Korea

I'd like to express my gratitude for your contributions to UML, which is
helping me tremendously


I discovered a bug in your  X86_64 configuration system a while back which
involves lost wakeups for rw semaphores

In what follows is an analysis of the problem

and I'd be much obliged if you'd commit it to the mainline kernel

The Kernel in question is 2.6.35.14



* Bug

1. two threads thread#0,#1 simultaneously attempt down_write(acquire)

2. thread#0 succeeds down_write, thread#1 fails down_write which causes it
to sleep in rwsem_down_failed_common

3. thread#0 finishes its work and calls up_write(release)

4. thread#0 calls rwsem_wake in up_write which should wakeup thread#1, but
it doesn't,

so rwsem_wake isn't called therefore wakeup never happens



* Source code and configurations

In arch/x86/lib/rwsem_64.S there is a condition in which call_rwsem_wake
calls rwsem_wake.

If the count value isn't properly maintained, wakeup never happens because
the condition statement fails

In printing the count value, I discovered that the counter is set for 32bit
systems while the condition check was for 64.

- ./arch/x86/include/asm/rwsem.h (macro for counter)

-----------------------------------------------------------------

#ifdef CONFIG_X86_64

#define RWSEM_ACTIVE_MASK 0xffffffffL

#else

#define RWSEM_ACTIVE_MASK 0x0000ffffL

#endif

-----------------------------------------------------------------

- ./arch/x86/lib/Makefile (condition check function selecting mechanism)

-----------------------------------------------------------------

ifeq ($(CONFIG_X86_32),y)

...

lib-y += semaphore_32.o string_32.o

...

else

...

lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem_64.o

endif

-----------------------------------------------------------------

- ./.config (neither CONFIG_X86_64 nor CONFIG_X86_32 are defined)

-----------------------------------------------------------------

#CONFIG_X86_32 is not set

-----------------------------------------------------------------

because neither CONFIG_X86_64 nor CONFIG_X86_32 are defined

header file's macro is built for 32bit and the checking function is for 64.


* Solution

in arch/um/Kconfig.x86 add "X86_64" (the boldface part) config as in
arch/x86/Kconfig

-----------------------------------------------------------------

config 64BIT

    bool

    default SUBARCH = "x86_64"



*config X86_64*

*    def_bool 64BIT*



config X86_32

    def_bool !64BIT

-----------------------------------------------------------------

thank you for your time

--001517592f1cc91a7f04b77aa248
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi</p>
<p>My name is Sunghan Suh and I&#39;m a software engineer for a software co=
mpany in=20
South Korea=A0</p>
<p>I&#39;d like to express my gratitude for your contributions to UML, whic=
h is=20
helping me tremendously=A0</p>
<p><br></p>
<p>I discovered a bug in your =A0X86_64 configuration system a while back w=
hich=20
involves lost wakeups for rw semaphores=A0</p>
<p>In what follows is an analysis of the problem</p>
<p>and I&#39;d be much obliged if you&#39;d commit it to the mainline kerne=
l</p>
<p>The Kernel in question is 2.6.35.14</p>
<p>=A0</p>
<p>* Bug</p>
<p>1. two threads thread#0,#1=A0simultaneously=A0attempt down_write(acquire=
)=A0</p>
<p>2. thread#0 succeeds down_write, thread#1 fails down_write which causes =
it to=20
sleep in rwsem_down_failed_common</p>
<p>3. thread#0 finishes its work and calls up_write(release)</p>
<p>4. thread#0 calls rwsem_wake in up_write which should wakeup thread#1, b=
ut it=20
doesn&#39;t,=A0</p>
<p>so rwsem_wake isn&#39;t called therefore wakeup never happens</p>
<p>=A0</p>
<p>* Source code and configurations</p>
<p>In arch/x86/lib/rwsem_64.S there is a condition in which call_rwsem_wake=
=20
calls rwsem_wake.</p>
<p>If the count value isn&#39;t properly maintained, wakeup never happens b=
ecause=20
the condition statement fails</p>
<p>In printing the count value, I discovered that the counter is set for 32=
bit=20
systems while the condition check was for 64.</p>
<p>- ./arch/x86/include/asm/rwsem.h (macro for counter)</p>
<p>-----------------------------------------------------------------</p>
<p>#ifdef CONFIG_X86_64</p>
<p>#define RWSEM_ACTIVE_MASK 0xffffffffL</p>
<p>#else</p>
<p>#define RWSEM_ACTIVE_MASK 0x0000ffffL</p>
<p>#endif</p>
<p>-----------------------------------------------------------------</p>
<p>- ./arch/x86/lib/Makefile (condition check function selecting mechanism)=
</p>
<p>-----------------------------------------------------------------</p>
<p>ifeq ($(CONFIG_X86_32),y)</p>
<p>...=A0</p>
<p>lib-y +=3D semaphore_32.o string_32.o</p>
<p>...</p>
<p>else</p>
<p>...</p>
<p>lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=3D rwsem_64.o</p>
<p>endif</p>
<p>-----------------------------------------------------------------</p>
<p>- ./.config (neither CONFIG_X86_64 nor CONFIG_X86_32 are defined)</p>
<p>-----------------------------------------------------------------</p>
<p>#CONFIG_X86_32 is not set</p>
<p>-----------------------------------------------------------------=A0</p>
<p>because neither CONFIG_X86_64 nor CONFIG_X86_32 are defined</p>
<p>header file&#39;s macro is built for 32bit and the checking function is =
for=20
64.</p>
<p><br></p>
<p>* Solution</p>
<p>in arch/um/Kconfig.x86 add &quot;X86_64&quot; (the boldface part) config=
 as in=20
arch/x86/Kconfig</p>
<p>-----------------------------------------------------------------</p>
<p>config 64BIT</p>
<p>=A0 =A0 bool</p>
<p>=A0 =A0 default SUBARCH =3D &quot;x86_64&quot;</p>
<p>=A0</p>
<p><b>config X86_64</b></p>
<p><b>=A0 =A0 def_bool 64BIT</b></p>
<p>=A0</p>
<p>config X86_32</p>
<p>=A0 =A0 def_bool !64BIT</p>
<p>-----------------------------------------------------------------=A0</p>
<p>thank you for your time</p>

--001517592f1cc91a7f04b77aa248--


--===============5897239196174206736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
--===============5897239196174206736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5897239196174206736==--


