Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <3FEF045C.90204@libero.it>
From: Domenico Andreoli <cavok@libero.it>
MIME-Version: 1.0
Subject: Re: [uml-user] Re: [uml-devel] UML patches against vanilla 2.6.0
References: <200312261905.48277.blaisorblade_spam@yahoo.it> <Pine.LNX.4.58.0312280851350.2434@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0312280851350.2434@boston.corp.fedex.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sun, 28 Dec 2003 17:27:08 +0100
To: Jeff Chua <jeff98@silk.corp.fedex.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net

Jeff Chua wrote:
> Here's what I did ...
> 
> My real linux version is 2.4.24-pre1. My /usr/src/linux points to 2.6.0
> with reiser4 and Ingo Molnar's uml-combo-2.6.0-A5 patch applied ... in
> order for "make menconfig" to set CONFIG_PROC_MM=y
> 
> Here's my patch against Ingo Molnar's uml-combo-2.6.0-A5 patch to make the
> patch works if you use reiser4 ...
> 
ehm... i was not able to apply this patch...

> After that patch, it'll be followed by another patch pointed out by
> BlaisorBlade ...
> 
> 
... and also this. maybe it's a problem with cut&paste...

would you be so kind to make them with diff -u and post them as attachment?

many thanks
domenico

-----[ Domenico Andreoli, aka cavok
  --[ http://filibusta.crema.unimi.it/~cavok/gpgkey.asc
    ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
