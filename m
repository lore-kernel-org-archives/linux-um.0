Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200312060005.hB605YAv008283@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: bug in COW? - Re: [uml-user] uml 2.6.0-test9 crash 
In-Reply-To: Your message of "Thu, 27 Nov 2003 17:28:59 PST."
             <Pine.LNX.4.53L0.0311271721550.27408@alpha.temple-baptist.com> 
References: <Pine.LNX.4.44.0311280047120.28924-100000@filer.marasystems.com> <010c01c3b54d$99552830$2000000a@schlepptopp>  <Pine.LNX.4.53L0.0311271721550.27408@alpha.temple-baptist.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 05 Dec 2003 19:05:34 -0500
To: Erik Walthinsen <omega@temple-baptist.com>
Cc: UML User list <user-mode-linux-user@lists.sourceforge.net>, UML Devel list <user-mode-linux-devel@lists.sourceforge.net>

omega@temple-baptist.com said:
> I've also run into the fact that something (either UML or the shell)
> seems to cause any symlinks in the path to be factored out as well.

It's UML.  I didn't want backing file paths to be invalidated by a component
of a symlink going away when the backing file is still perfectly accessible.

> This means that any images I try to locate in the same place at all
> times, regardless of physical location, still end up being stored as
> their physical location. 

I don't parse that at all.  Can you try again, maybe with an example or two?

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
