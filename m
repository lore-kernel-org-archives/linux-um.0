Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Workaround for bug #851759 -  SuSE YAST in textmode
 does not work
In-Reply-To: <055801c3bd22$f1a1b3f0$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0312081042480.9997-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 8 Dec 2003 10:44:31 +0100 (CET)
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>, Gerd Knorr <kraxel@bytesex.org>

On Mon, 8 Dec 2003, roland wrote:

> digging deeper into yast, i found that yast (fortunately) uses a special
> "ycp" Scripting language. A menu-entry in yast consinsts of several ycp
> modules. a module, which loads quite often is the module "Arch.ycp".
> with that, yast seems to detect, which hardware architecture it`s
> running on.

Are you running UML in TT or SKAS mode?

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
