Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbTGy-0006O9-IB	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:04:24 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DbTGw-0006kO-Oe	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:04:24 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050527003843.433BA1AEE88@zion.home.lan>
In-Reply-To: <20050527003843.433BA1AEE88@zion.home.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505270306.09425.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 4/8] irq code: Add coherence test for
	PREEMPT_ACTIVE
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
Date: Fri, 27 May 2005 03:06:09 +0200
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org, dhowells@redhat.com

On Friday 27 May 2005 02:38, blaisorblade@yahoo.it wrote:
> After porting this fixlet to UML:
>
> http://linux.bkbits.net:8080/linux-2.5/cset@41791ab52lfMuF2i3V-eTIGRBbDYKQ
>
> , I've also added a warning which should refuse compilation with insane
> values for PREEMPT_ACTIVE... maybe we should simply move PREEMPT_ACTIVE out
> of architectures using GENERIC_IRQS.
Ok, a grep shows that possible culprits (i.e. giving success to
grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as PREEMPT_ACTIVE, 
as given by grep PREEMPT_ACTIVE include/asm-*/thread_info.h) are (at a first 
glance): frv, sh, sh64.

After a bit of checking, I also verified if they had overriden the value of 
HARDIRQ_BITS. Which they haven't (it seems it's defined exactly where 
CONFIG_HARDIRQS is not used, i.e. nobody is using the ability to override it 
currently).

This was not a very deep investigation, however, so feel free to verify this 
better.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
