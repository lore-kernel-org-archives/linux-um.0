Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
In-Reply-To: <20040316174518.A14227@lnxi.com>
Message-ID: <Pine.LNX.4.44.0403162043400.2148-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: 2.6.4 UML kernel available
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 16 Mar 2004 20:46:00 -0500 (EST)
To: Mike Snitzer <msnitzer@lnxi.com>
Cc: ML-uml-user <User-mode-linux-user@lists.sourceforge.net>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>

Good afternoon, Mike,

On Tue, 16 Mar 2004, Mike Snitzer wrote:

> On Tue, Mar 16 2004 at 15:17,
> Mike Snitzer <msnitzer@lnxi.com> wrote:
> 
> > On Fri, Mar 12 2004 at 00:27,
> > William Stearns <wstearns@pobox.com> wrote:
> > 
> > > * I'm having trouble finding the right command line to get Debian 3.0's 
> > > init to hook up to the console devices, but that's most certainly my 
> > > problem, and not the kernel's.
> > 
> > Has anyone had any luck tracking down a solution to Debian's init and
> > 2.6.4 (and I think 2.6.3) UML?  I'm having the same problem.
> 
> FYI, talking with others in #uml it seems that this is a problem specific
> to Debian testing's init.  Others have been able to boot a Debian stable
> image using 2.6.x; but can't do so with a Debian testing image.
> 
> Any insight/solutions to this would be very welcome.

	What's changed between the init in stable and the init in testing?  
Does Debian provide a changelog for the package?  In particular, any 
references to tty handling?
	Also, how could one _downgrade_ to the init in stable inside a
Debian virtual machine?
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "What you end up with, after running an operating system concept
through these many marketing coffee filters, is something not unlike
plain hot water."
        -- Matt Welsh
(Courtesy of Theo Van Dinter <felicity@kluge.net>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
