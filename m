Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Crn4H-00023n-Ja for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Jan 2005 16:54:29 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Crn4F-0004Km-Vy
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Jan 2005 16:54:29 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] UML build process uses perl? (With sed alternative.)
References: <200501140040.56592.rob@landley.net>
	<200501200125.01522.rob@landley.net>
	<200501210031.j0L0VN3u005305@ccure.user-mode-linux.org>
In-Reply-To: <200501210031.j0L0VN3u005305@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501201852.48095.rob@landley.net>
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
Date: Thu, 20 Jan 2005 18:52:47 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 20 January 2005 07:31 pm, Jeff Dike wrote:
> rob@landley.net said:
> > I still need the attached one-liner patch to get it to build under
> > uclibc,  though.
>
> What does that break, exactly?
>
> 				Jeff

  CC      arch/um/kernel/init_task.o
  CC      arch/um/kernel/irq.o
gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common 
-O2 -fomit-frame-pointer -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\" 
-D_LARGEFILE64_SOURCE   -Iarch/um/include 
-I/linux-2.6.9/arch/um/kernel/tt/include 
-I/linux-2.6.9/arch/um/kernel/skas/include -D_GNU_SOURCE  -c -o 
arch/um/kernel/irq_user.o arch/um/kernel/irq_user.c
In file included from arch/um/kernel/irq_user.c:16:
arch/um/include/user.h:15: error: conflicting types for `strlcpy'
/usr/include/string.h:384: error: previous declaration of `strlcpy'
make[1]: *** [arch/um/kernel/irq_user.o] Error 1
make: *** [arch/um/kernel] Error 2

This is because uclibc's string.h has this snippet:

#ifdef	__USE_BSD
/* Two OpenBSD extension functions. */
extern size_t strlcat(char *__restrict dst, const char *__restrict src,
                      size_t n) __THROW;
extern size_t strlcpy(char *__restrict dst, const char *__restrict src,
                      size_t n) __THROW;
#endif

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
