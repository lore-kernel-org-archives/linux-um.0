Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: Workaround for bug #851759 -  SuSE YAST in textmode does not work
Message-ID: <20031212085841.GC15551@bytesex.org>
References: <20031208095906.GB22878@bytesex.org> <Pine.LNX.4.44.0312081233150.10622-100000@filer.marasystems.com> <20031211120056.GA5347@bytesex.org> <044301c3c032$0789b930$2000000a@schlepptopp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044301c3c032$0789b930$2000000a@schlepptopp>
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
Date: Fri, 12 Dec 2003 09:58:41 +0100
To: roland <for_spam@gmx.de>
Cc: Henrik Nordstrom <hno@marasystems.com>, user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Thu, Dec 11, 2003 at 10:59:13PM +0100, roland wrote:
> mhhh,
> that result is different to the results i posted.
> what uml on what host are you using?

Host is 2.4.23, uml was 2.4.20.
Just retested with a 2.6.0-test9 uml kernel, same results with one exeption:

> > test1 does *not* print a "Segmentation fault" message as it should
> > (and does outside a uml machine).

I do get the "Segmentation fault" message with test1.

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
