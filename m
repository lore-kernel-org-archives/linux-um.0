Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrMdb-00056Y-ST for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 12:41:11 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CrMdX-0006Sp-Sf for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 12:41:11 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML build process uses perl? (With sed alternative.)
References: <200501140040.56592.rob@landley.net>
In-Reply-To: <200501140040.56592.rob@landley.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_70q7BwMRIBt82QB"
Message-Id: <200501191955.55131.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 19 Jan 2005 19:55:54 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

--Boundary-00=_70q7BwMRIBt82QB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 14 January 2005 06:40, Rob Landley wrote:
> I thought maybe the problem I'm having is due to running UML with a uclibc
> root on a glibc host system, so I tried to build UML in my chroot
> environment.
>
> It died when it tried to use perl to build.
>
> My uclibc environment hasn't got perl.  The normal linux kernel build
> doesn't use perl.  Neither do busybox, lilo, uClibc, zlib, dropbear,
> autoconf, automake, bin86, binutils, bison, cdrtools, e2fsprogs, flex, gcc,
> libtool, m4, make, nasm, the squashfs or zisofs tools, udev, or any of the
> other packages I build under the thing.
>
> As far as I can tell, the following sed invocation will give more or less
> what the perl does, without a dependency on perl.  (Busybox has sed.)  It
> may need a bit of adapting to make the makefile happy (and adding
> config.tmp to make clean), but the concept seems to work...
>
> sed -e 's/^.*$/"&\\n"/' /linux-2.6.9/.config > config.tmp

It's ok, if the "&" stands for the matched string as I recall; I've done it 
through this equivalent form:

sed -e 's/^/"/' -e 's/$/\\n"/' .config > config.tmp

I've also modified this further below for a different requirement.

The only potential problem is the use of the temporary file which is not nice, 
however your need seems more important in fact...

> sed -e '/CONFIG/{' -e 's/"CONFIG"\;/""/' -e 'r config.tmp' -e 'a ""\;' \
>  -e '}' config.c.in
If you compare that with the real result, it does not match - and you see it 
because double quotes in .config (which exist, yes) are not escaped as here 
(the dollar is escaped in the original):

$config =~ s/"/\\"/g;

So I've done it this way:

sed -e 's/"/\\"/g' -e 's/^/"/' -e 's/$/\\n"/' .config > config.tmp
i.e. first escape the double quotes, then add unescaped double quotes at start 
and end, and then do what you do:

sed -e '/CONFIG/{' -e 's/"CONFIG"\;/""/' -e 'r config.tmp' -e 'a""\;' -e '}' 
arch/um/kernel/config.c.in > arch/um/kernel/config.c

Which gives the same result as the original method (there is one trivial 
difference at the beginning of the output which is, IMHO, purely cosmethical:

--- arch/um/kernel/config.c     2005-01-19 18:51:48.174446032 +0100
+++ ./config.c  2005-01-19 18:52:46.015652832 +0100
@@ -9,3 +9,4 @@

-static __initdata char *config = "#\n"
+static __initdata char *config = ""
+"#\n"
 "# Automatically generated make config: don't edit\n"

This actually should work, indeed, if translated in the Makefile... which 
should be more or less like the attached patch.

Also, I wanted to avoid writing more -e options for the same programs, to have 
it clearer... however I had problems to do it in the Makefile, so I

Please double-check that the patch works with your busybox sed implementation, 
and compare the original and the new obtained config.c carefully, since the 
sed code you supplied wasn't good.

In fact, I'm no expert in sed portability, so I'm not sure if it behaves well 
with busybox (actually I'm no sed expert, so it was difficult for me to read 
your code at first).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_70q7BwMRIBt82QB
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-do-not-rely-on-perl-for-building.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-do-not-rely-on-perl-for-building.patch"


To quote .config into config.c for building the result into the code, use sed
instead of perl, as requested by one "embedded" UML user (which notes that perl
is a big requirement, while busybox provides sed which is used in this patch).

I've tested that there are only cosmethical differences in the produced
config.c file, which don't change at all the result (i.e. "a" is replaced by
"" "a" at the beginning, which is non-significant).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/Makefile |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff -puN arch/um/kernel/Makefile~uml-do-not-rely-on-perl-for-building arch/um/kernel/Makefile
--- linux-2.6.11/arch/um/kernel/Makefile~uml-do-not-rely-on-perl-for-building	2005-01-19 18:56:13.163161624 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/Makefile	2005-01-19 19:52:39.296391128 +0100
@@ -4,7 +4,7 @@
 #
 
 extra-y := vmlinux.lds
-clean-files := vmlinux.lds.S
+clean-files := vmlinux.lds.S config.tmp
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
@@ -33,11 +33,25 @@ CFLAGS_frame.o := -fno-omit-frame-pointe
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(USER_CFLAGS) $(CFLAGS_$(notdir $@)) -c -o $@ $<
 
-QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
+targets += config.c
 
-quiet_cmd_quote = QUOTE   $@
-cmd_quote = $(PERL) -e $(QUOTE) < $< > $@
+#Be careful with the below Sed code - sed is pitfall-rich!
+#We use sed to lower build requirements, for "embedded" builders for instance.
 
-targets += config.c
-$(obj)/config.c : $(src)/config.c.in $(TOPDIR)/.config FORCE
-	$(call if_changed,quote)
+$(obj)/config.tmp: $(objtree)/.config FORCE
+	$(call if_changed,quote1)
+
+quiet_cmd_quote1 = QUOTE   $@
+      cmd_quote1 = sed -e 's/"/\\"/g' -e 's/^/"/' -e 's/$$/\\n"/' \
+		   $< > $@
+
+$(obj)/config.c: $(src)/config.c.in $(obj)/config.tmp FORCE
+	$(call if_changed,quote2)
+
+quiet_cmd_quote2 = QUOTE   $@
+      cmd_quote2 = sed -e '/CONFIG/{'		\
+     		   -e 's/"CONFIG"\;/""/'	\
+		   -e 'r $(obj)/config.tmp'	\
+		   -e 'a""\;'			\
+		   -e '}'			\
+		   $< > $@
_

--Boundary-00=_70q7BwMRIBt82QB--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
