Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Re: Workaround for bug #851759 -  SuSE YAST in
 textmode does not work
In-Reply-To: <20031211120056.GA5347@bytesex.org>
Message-ID: <Pine.LNX.4.44.0312111357440.25617-100000@filer.marasystems.com>
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
Date: Thu, 11 Dec 2003 13:58:54 +0100 (CET)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Thu, 11 Dec 2003, Gerd Knorr wrote:

> The test seems to work correctly.  Probably it tries to access a "magic"
> i/o port which is used for communication between vmware and guest os,
> but I don't know for sure.

This is what the test does, and this will give a false positive when 
running UML within vmware making SuSe think it is running on vmware 
hardware when it is not really (UML and the host kernel is inbetween)

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
