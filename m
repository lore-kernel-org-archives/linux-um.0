Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed24S-0005WP-S1 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 00:58:12 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ed24R-0002X6-Ky
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 00:58:13 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
References: <200511121936.41697.rob@landley.net>
	<200511180136.30434.rob@landley.net>
	<200511180858.02124.blaisorblade@yahoo.it>
In-Reply-To: <200511180858.02124.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180258.02082.rob@landley.net>
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
Date: Fri, 18 Nov 2005 02:58:01 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 18 November 2005 01:58, Blaisorblade wrote:
> On Friday 18 November 2005 08:36, Rob Landley wrote:
> > On Friday 18 November 2005 01:43, Blaisorblade wrote:
> > > On Wednesday 16 November 2005 04:09, Rob Landley wrote:
> > > > On Monday 14 November 2005 13:40, Blaisorblade wrote:
> > >
> > > Ok, clearer: could you try removing altogether that -rlink? I'm trying
> > > here too right now... will follow up with results.
> >
> > I believe I tried that already and the error was the same as when it had
> > the wrong directory.
>
> Ok, right - can you try adding both rlink now (first lib64 and then lib)? I
> gathered some more insight and it should work.

Actually, since the rpath line appends arguments to whatever's already there
and Makefile-$ARCH gets included before that, I suspect the correct thing to
do is append 

LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64

to the end of "arch/um/Makefile-x86_64".  Order should work out ok, and the
path is only modified for x86-64...

The ld man page says:
      -rpath dir
           Add a directory to the runtime library search path.  This  is  used
           when  linking  an  ELF  executable with shared objects.  All -rpath
           arguments are concatenated and passed to the runtime linker,  which
           uses  them  to locate shared objects at runtime.  The -rpath option
           is also used when locating  shared  objects  which  are  needed  by
           shared objects explicitly included in the link; see the description
           of the -rpath-link option.

So that concatenates multiple arguments...

And it worked beautifully.  Here's your patch:

--- linux-2.6.14/arch/um/Makefile-x86_64 2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc1/arch/um/Makefile-x86_64 2005-11-18 09:55:39.984601688 +0100
@@ -12,3 +12,5 @@
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
+
+LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
