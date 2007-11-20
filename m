Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Tue, 20 Nov 2007 12:05:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071120170551.GB7211@c2.user-mode-linux.org>
References: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
	<fbeb04f6d7134565611741ad0148e1b401362ef9.1195454434.git.joe@perches.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fbeb04f6d7134565611741ad0148e1b401362ef9.1195454434.git.joe@perches.com>
Subject: Re: [uml-devel] [PATCH 08/59] arch/um: Add missing "space"
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
To: Joe Perches <joe@perches.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net

On Mon, Nov 19, 2007 at 05:48:00PM -0800, Joe Perches wrote:
> -		printk(UM_KERN_ERR "vde_init_libstuff - vde_open_args"
> +		printk(UM_KERN_ERR "vde_init_libstuff - vde_open_args "

Applied, thanks.

		Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
