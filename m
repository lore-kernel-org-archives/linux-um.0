Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KCHUT-00005t-R0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jun 2008 10:12:05 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KCHUQ-0003vX-MP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jun 2008 10:12:05 -0700
Date: Fri, 27 Jun 2008 12:26:45 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080627162645.GC8381@c2.user-mode-linux.org>
References: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>
Subject: Re: [uml-devel] [PATCH] fix extern inline errors with gcc 4.3.0
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
To: Benny Halevy <bhalevy@panasas.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 26, 2008 at 04:50:51PM +0300, Benny Halevy wrote:
> -KBUILD_CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
> +# Disable unit-at-a-time mode on pre-gcc-4.3 compilers, it makes gcc use
> +# a lot more stack due to the lack of sharing of stacklots:
> +# gcc 4.3.0 needs -funit-at-a-time for extern inline functions
> +KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0403 ] ; then \
> +			echo $(call cc-option,-fno-unit-at-a-time); fi ;)

How do we know that this patch won't cause the same crash reported in
http://marc.info/?l=linux-kernel&m=121011722806093&w=2?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
