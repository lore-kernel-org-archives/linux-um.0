Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: Workaround for bug #851759 -  SuSE YAST in textmode does not work
Message-ID: <20031211120056.GA5347@bytesex.org>
References: <20031208095906.GB22878@bytesex.org> <Pine.LNX.4.44.0312081233150.10622-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312081233150.10622-100000@filer.marasystems.com>
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
Date: Thu, 11 Dec 2003 13:00:56 +0100
To: Henrik Nordstrom <hno@marasystems.com>
Cc: roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Wed, Dec 10, 2003 at 10:14:07PM +0100, Henrik Nordstrom wrote:
> On Mon, 8 Dec 2003, Gerd Knorr wrote:
> 
> > IMHO this one is a UML kernel bug.
> 
> The hang certainly can be considered a UML bug.
> 
> I think the same hang should be seen on any SIGSEGV due to incorrect X86
> I/O operations. Can you try these two simple programs to try to isolate 
> the error?

> /* test1.c */

> /* test2.c */

Both test do hang (until doing something else in another terminal).
test1 does *not* print a "Segmentation fault" message as it should
(and does outside a uml machine).

> The test as such will however (if not hanging) give a false positive if
> UML is running within vmware and can be questioned unless complemented 
> with a UML test.

The test seems to work correctly.  Probably it tries to access a "magic"
i/o port which is used for communication between vmware and guest os,
but I don't know for sure.

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
