Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiHgw-0003VY-Gk for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 10:30:34 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AiHgv-00038p-VT for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 10:30:34 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] /dev/anon available
References: <200401130510.i0D5AlS4026784@ccure.user-mode-linux.org>
	<200401172048.47847.blaisorblade_spam@yahoo.it>
	<20040118045439.GE8571@ccure.user-mode-linux.org>
In-Reply-To: <20040118045439.GE8571@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401181637.35418.blaisorblade_spam@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Sun, 18 Jan 2004 17:13:38 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 05:54, domenica 18 gennaio 2004, Jeff Dike ha scritto:
> On Sat, Jan 17, 2004 at 08:48:47PM +0100, BlaisorBlade wrote:
> > I've given a look to the page, but yet I cannot see (this can be for my
> > fault, but I'd really like an explaination of this) why you couldn't just
> > mmap /dev/zero with MAP_PRIVATE to get the behaviour you want to get from
> > /dev/anon (or maybe using MAP_ANONYMOUS).
>
> Because when you map a /dev/zero page, modify it, then map it (i.e. the
> same offset and the same fd) again someplace else, you don't get the
> modifications. You get a page full of zeros.   This obviously breaks the
> UML VM system.

Yes, that's obvious with MAP_PRIVATE (and using MAP_SHARED would be 
meaningless, if at all worked). But I wasn't aware you needed to map the same 
region twice; I guess this is done for pages shared (even with copy on write) 
between different processes inside UML, right? Also, since with skas the 
mm_struct's of the virtual processes have nothing in common, they cannot

However, have you asked to Linus if he likes /dev/anon? Maybe he'll suggest 
another interface for the same need (like when you two discussed skas4).

-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
