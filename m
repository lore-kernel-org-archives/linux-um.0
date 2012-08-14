Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dhowells@redhat.com>) id 1T1I5O-0001nR-9T
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 14:27:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T1I5M-0000W3-6z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 14:27:10 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <87a9xys53h.fsf@rustcorp.com.au>
References: <87a9xys53h.fsf@rustcorp.com.au>
	<20120726150419.0de645e8750e3a15fa0f1aaa@canb.auug.org.au>
	<50115FCF.4060708@xenotime.net> <502932A0.3060001@xenotime.net>
Date: Tue, 14 Aug 2012 15:26:53 +0100
Message-ID: <15532.1344954413@warthog.procyon.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-next: Tree for July 26 (uml)
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org


Rusty Russell <rusty@rustcorp.com.au> wrote:

> > >   CC      arch/x86/um/../kernel/module.o
> > > arch/x86/um/../kernel/module.c:96:5: error: redefinition of 'apply_relocate_add'
> > > include/linux/moduleloader.h:64:19: note: previous definition of 'apply_relocate_add' was here
> > > make[2]: *** [arch/x86/um/../kernel/module.o] Error 1

Hmmm...  I'm not sure how to deal with this.  The problem is that UML doesn't
draw the:

	select MODULES_USE_ELF_REL if X86_32
	select MODULES_USE_ELF_RELA if X86_64

definitions from arch/foo/Kconfig that tell it what modules will look like.

Should I just enable both REL and RELA in UML, or is there a better way to do
this?

David

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

