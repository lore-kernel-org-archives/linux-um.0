Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: Workaround for bug #851759 -  SuSE YAST in textmode does not work
Message-ID: <20031211140607.GA6359@bytesex.org>
References: <20031211120056.GA5347@bytesex.org> <Pine.LNX.4.44.0312111357440.25617-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312111357440.25617-100000@filer.marasystems.com>
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
Date: Thu, 11 Dec 2003 15:06:08 +0100
To: Henrik Nordstrom <hno@marasystems.com>
Cc: roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

> This is what the test does, and this will give a false positive when 
> running UML within vmware making SuSe think it is running on vmware 
> hardware when it is not really (UML and the host kernel is inbetween)

Ah, *that* corner case you are talking about.  Yea, in that case it
will succeed although it doesn't run (directly) on vmware.

  Gerd

-- 
You have a new virus in /var/mail/kraxel


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
