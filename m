Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3PBl-00069Z-Bv for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Mar 2004 16:45:41 -0800
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]
	helo=ash.lnxi.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B3PBj-0004Z7-QR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Mar 2004 16:45:39 -0800
From: Mike Snitzer <msnitzer@lnxi.com>
Message-ID: <20040316174518.A14227@lnxi.com>
References: <Pine.LNX.4.44.0403120222160.2524-100000@sparrow>
	<20040316151745.B12857@lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316151745.B12857@lnxi.com>;
	from msnitzer@lnxi.com on Tue, Mar 16, 2004 at 03:17:45PM -0700
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
Date: Tue, 16 Mar 2004 17:45:18 -0700
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-user <User-mode-linux-user@lists.sourceforge.net>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Mar 16 2004 at 15:17,
Mike Snitzer <msnitzer@lnxi.com> wrote:

> On Fri, Mar 12 2004 at 00:27,
> William Stearns <wstearns@pobox.com> wrote:
> 
> > * I'm having trouble finding the right command line to get Debian 3.0's 
> > init to hook up to the console devices, but that's most certainly my 
> > problem, and not the kernel's.
> 
> Has anyone had any luck tracking down a solution to Debian's init and
> 2.6.4 (and I think 2.6.3) UML?  I'm having the same problem.

FYI, talking with others in #uml it seems that this is a problem specific
to Debian testing's init.  Others have been able to boot a Debian stable
image using 2.6.x; but can't do so with a Debian testing image.

Any insight/solutions to this would be very welcome.

Mike


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
