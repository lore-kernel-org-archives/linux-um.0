Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ET4Cq-0006sM-AX	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 14:13:40 -0700
Received: from mail06.syd.optusnet.com.au ([211.29.132.187])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1ET4Co-0008S8-MQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 14:13:40 -0700
Received: from [192.168.1.20] (c210-49-175-223.mckinn1.vic.optusnet.com.au
	[210.49.175.223])j9LLDV2M008333
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 22 Oct 2005 07:13:31 +1000
Subject: Re: [uml-devel] 2.6.13.4-bs4 released - fixes for SKAS0 problems -
	careful about COW
From: Phill Wombat <uml@webwombat.com>
In-Reply-To: <200510211120.08231.blaisorblade@yahoo.it>
References: <200510151325.50461.blaisorblade@yahoo.it>
	 <1129841654.10146.14.camel@localhost.localdomain>
	 <200510211120.08231.blaisorblade@yahoo.it>
Content-Type: text/plain; charset="utf-8"
Message-Id: <1129929210.10146.22.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Sat, 22 Oct 2005 07:13:30 +1000
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Fixed!! Compiles OK now.

Thanks
Phill.

On Fri, 2005-10-21 at 11:20 +0200, Blaisorblade wrote:
> On Thursday 20 October 2005 22:54, Phill Wombat wrote:
> > Hi List,
> >
> > Start the process of compiling 2.6.13.4-bs4.
> >
> > x86_64 host, i386 UML.
> >
> > Using same config as successful 2.6.12.5-bb12-skas0.
> >
> > Some compile errors encountered:
> Can't reproduce that on my i386 host, and probably can't reproduce it on my 
> x86_64 compile environment (but I'm too lazy to reboot there).
> 
> I would bet your glibc headers have a bug somewhere (this seems a "double 
> inclusion of the same header" problem). However, try the attached patch.
> 
> > ================ SNIP ======================
> 
> >   AS      arch/um/sys-i386/stub.o
> >   CC      arch/um/sys-i386/stub_segv.o
> > In file included from /usr/include/asm/sigcontext.h:7,
> >                  from arch/um/sys-i386/stub_segv.c:7:
> > /usr/include/asm-i386/sigcontext.h:18: error: redefinition of ‘struct
> > _fpreg’ /usr/include/asm-i386/sigcontext.h:23: error: redefinition of
> > ‘struct _fpxreg’ /usr/include/asm-i386/sigcontext.h:29: error: redefinition
> > of ‘struct _xmmreg’ /usr/include/asm-i386/sigcontext.h:33: error:
> > redefinition of ‘struct _fpstate’ /usr/include/asm-i386/sigcontext.h:57:
> > error: redefinition of ‘struct sigcontext’ make[1]: ***
> > [arch/um/sys-i386/stub_segv.o] Error 1
> 



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
