Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jdike@addtoit.com>) id 1ZCxZ2-0000Ub-9U
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jul 2015 22:11:36 +0000
Received: from u16576595.onlinehome-server.com ([74.208.238.6]
	helo=euler.addtoit.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZCxZ1-0000lq-8T for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jul 2015 22:11:36 +0000
Date: Wed, 8 Jul 2015 18:11:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20150708221128.GB10669@parts.user-mode-linux.org>
References: <1436382947-13181-1-git-send-email-christophe.jaillet@wanadoo.fr>
	<559D77D3.3030906@nod.at>
	<20150708195644.GA532@parts.user-mode-linux.org>
	<559D8193.3090202@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <559D8193.3090202@nod.at>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: umid: Use strdup to simplify code
To: Richard Weinberger <richard@nod.at>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jul 08, 2015 at 10:01:23PM +0200, Richard Weinberger wrote:
> BTW: I'd like to move away from sf.net soon. Maybe to lists.infradead.org.
> Is that okay for you?

Fine by me - it's your call.

			Jeff

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

