Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <20090111142906.6d8b1795@mistral.stie>
References: <20090111142906.6d8b1795@mistral.stie>
Date: Tue, 13 Jan 2009 16:57:41 +0800
Message-ID: <9bd6b5360901130057j64a962e7p299b26acc37feffc@mail.gmail.com>
From: sniper <s3c24xx@gmail.com>
Subject: Re: [uml-devel] [uml-user] Error building with VDE
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
To: lanas <lanas@securenet.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>

On Mon, Jan 12, 2009 at 3:29 AM, lanas <lanas@securenet.net> wrote:
> Hello,
>
>  I get the gollowing errors when building 2.6.26.8 with option for VDE
> enabled:
>
> arch/um/drivers/vde_user.c: In function 'vde_init_libstuff':
> arch/um/drivers/vde_user.c:81: erreur: implicit declaration of function 'kmalloc'
>
> The make comnmands are the follwoing:
>
> make mrproper ARCH=um
> make defconfig ARCH=um
> make menuconfig ARCH=um
>
> (set only option VDE)

Cc to user-mode-linux-devel.

Anybody notices this? UML in the latest linus-git has the same problem.

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
