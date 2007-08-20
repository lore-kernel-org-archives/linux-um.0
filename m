Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INDNC-0001Mi-FN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2007 12:57:14 -0700
Received: from mailout.stusta.mhn.de ([141.84.69.5] helo=mailhub.stusta.mhn.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1INDN9-0004nU-Lh
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2007 12:57:14 -0700
Date: Mon, 20 Aug 2007 21:55:22 +0200
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20070820195522.GG32595@stusta.de>
References: <20070817194340.GA8734@c2.user-mode-linux.org>
	<20070820124030.d603b928.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070820124030.d603b928.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH 1/6] UML - Fix inlines
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Dike <jdike@addtoit.com>, Adrian Bunk <bunk@kernel.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Aug 20, 2007 at 12:40:30PM -0700, Andrew Morton wrote:
> On Fri, 17 Aug 2007 15:43:40 -0400
> Jeff Dike <jdike@addtoit.com> wrote:
> 
> > "extern inline" will have different semantics with gcc 4.3.
> 
> What are these different semantics?

With gcc <= 4.2, when using "extern inline" in no case the function is
compiled on its own, not even if you refer to its address explicitly.  
Such an address becomes an external reference, as if you had only 
declared the function, and had not defined it.

In C99 (and therefore in gcc >= 4.3), "extern inline" means that the 
function should be compiled inline where the inline definition is seen, 
and that the compiler should also emit a copy of the function body with 
an externally visible symbol.

Except for the Alpha port all users in the kernel used "extern inline" 
only for getting "static inline" semantics (older gcc versions didn't 
offer the always_inline function attribute).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
