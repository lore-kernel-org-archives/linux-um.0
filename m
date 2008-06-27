Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Fri, 27 Jun 2008 13:54:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080627175426.GH8381@c2.user-mode-linux.org>
References: <20080621223401.C97C.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080621223401.C97C.WEIYI.HUANG@gmail.com>
Subject: Re: [uml-devel] arch/um/os-Linux/helper.c: Removed duplicated include
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
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: jdike@addtoit.com, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Sat, Jun 21, 2008 at 10:34:23PM +0800, Huang Weiyi wrote:
> Removed duplicated include file <linux/limits.h> in 
> arch/um/os-Linux/helper.c.

Yup, I passed along a patch from Ingo without noticing that it had
already gone in.

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
