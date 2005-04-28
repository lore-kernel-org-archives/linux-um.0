Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DR1lB-0006S8-4V for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 22:40:25 -0700
Received: from rwcrmhc14.comcast.net ([216.148.227.89])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DR1l9-00031D-Oh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 22:40:25 -0700
From: Ryan Anderson <ryan@michonline.com>
Message-ID: <20050428054015.GC30308@mythryan2.michonline.com>
References: <1114570958.5983.50.camel@mythical>
	<20050427234515.GY13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427234515.GY13052@parcelfarce.linux.theplanet.co.uk>
Subject: [uml-devel] Re: [UML] Compile error when building with seperate
	source and object directories
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
Date: Thu, 28 Apr 2005 01:40:15 -0400
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, sam@ravnborg.org, Ryan Anderson <ryan@michonline.com>

On Thu, Apr 28, 2005 at 12:45:15AM +0100, Al Viro wrote:
> On Tue, Apr 26, 2005 at 11:02:38PM -0400, Ryan Anderson wrote:
> > I've been seeing a build error when trying to build User Mode Linux on
> > an x86-32 host (Athlon, fwiw).  The kernel I'm building is a 1-day old
> > pull from git.  This error is not new, though.  I thought it was merely
> > an artifact of a patch stuck in a queue at first so I didn't mention it
> > right away.
> 
> That's because that stuff is not merged yet.  Speaking of which, where does
> the current UML tree live and who should that series be Cc'ed to?

I think you hit the right people with the Cc: list I started with.

> I've got a decent split-up and IMO that should be mergable.  Patches are
> on ftp.linux.org.uk/pub/people/viro/UM*; summary in the end of mail.
> That's a sanitized and split version of old UML-kbuild patch.

Thanks, this seems to do the trick.

I had an initial problem, but I think I was just working from a
directory in a bad state, after nuking my output directory and starting
over, it seems to be working just fine.

Thanks for the fix, I have another toy to play with this week now. :)

-- 

Ryan Anderson
  sometimes Pug Majere


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
