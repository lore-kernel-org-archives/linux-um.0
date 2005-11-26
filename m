Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Efx68-0002BH-Av for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 02:16:00 -0800
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Efx66-0006b5-U5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 02:16:00 -0800
From: Chris Lightfoot <chris@ex-parrot.com>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
Message-ID: <94jJvB83HN1Q.bQBgxIed7GoC9RvLy9LFzw@sphinx.mythic-beasts.com>
References: <200511240611.02613.rob@landley.net>
	<200511251418.43866.rob@landley.net>
	<F7Gh6QjS+CQJ.VbbzsRXr69warfFBfetWCw@sphinx.mythic-beasts.com>
	<200511260403.55274.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511260403.55274.rob@landley.net>
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
Date: Sat, 26 Nov 2005 10:15:48 +0000
To: Rob Landley <rob@landley.net>
Cc: Nix <nix@esperi.org.uk>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Nov 26, 2005 at 04:03:54AM -0600, Rob Landley wrote:
> On Friday 25 November 2005 17:46, Chris Lightfoot wrote:
> > On Fri, Nov 25, 2005 at 02:18:43PM -0600, Rob Landley wrote:
> > > Using /tmp for anything has been kind of discouraged for a while, because
> > > throwing any insufficiently randomized filename in there is a security
> > > hole waiting to happen.
> >
> > Which case are you worried about here? SFAIK all the
> > filesystems anyone is likely to mount on /tmp implement
> > O_EXCL correctly, and in any case (as was remarked
> > elsewhere) there's always mkdir.
> 
> I think programmers got the general impression using /tmp for temporary files 
> was a really stupid idea from the fact that it keeps cropping up on things 
> like LWN's security section.  Here's the ones they linked to just last week 
> as still being fixed by various distros:
    [...]

hmm. I'm not sure any of that's an argument for avoiding
use of /tmp in new programs. I'm not really sure what the
sensible alternative is, either: at least you can sensibly
write policy about (e.g.) cleaning old files out of /tmp
if you want to, whereas if you have multiple ad-hoc
policies for temporary files, you can't.

-- 
language not worship must pink delirious sleep produce
(fridge poetry)


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
