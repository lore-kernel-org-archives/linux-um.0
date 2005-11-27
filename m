Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgQ3J-00054P-SR for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 09:11:01 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EgQ3D-0004gy-8J
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 09:11:01 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511260033.25661.blaisorblade@yahoo.it>
	<200511260444.29470.rob@landley.net>
In-Reply-To: <200511260444.29470.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511271810.39194.blaisorblade@yahoo.it>
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
Date: Sun, 27 Nov 2005 18:10:38 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Nix <nix@esperi.org.uk>, Chris Lightfoot <chris@ex-parrot.com>

On Saturday 26 November 2005 11:44, Rob Landley wrote:
> On Friday 25 November 2005 17:33, Blaisorblade wrote:
> > On Friday 25 November 2005 22:04, Nix wrote:
> > > On Fri, 25 Nov 2005, Rob Landley moaned:
> > > > On Friday 25 November 2005 13:33, Nix wrote:

> That a normal user can allocate persistent memory, that outlives all their
> processes, with no special priviledges, and that the limits on it are per
> system rather than per user.  (In theory you can apply quota to /tmp but
> I've never seen anybody do it.  And yeah, shmfs is no worse than shmget,
> for obvious reasons.  Apparently System V wasn't big into reference
> counting.).

When I studied SysV API I've seen this being claimed and intended as a 
feature.

In the same way, the absence of garbage collection on filesystems is called a 
feature.

And in fact shmctl(IPC_RMID) does reference counting - the concept is exactly 
the same one as with filesystems and deleting files (argh, it's not so for 
anything else of the SysV APIvefd, unfortunately).

Additionally, on Linux, you can attach a shm region which is marked to be 
destroyed (not on other systems), and then you create a region and mark it 
for deletion, getting the desired behaviour.

The (big) misfeature is the miss of a purely refcounting option of the API as 
a standard, and the miss of a standard utility to clean the leftover cruft... 
(I think this can be called a potential local DoS on almost all deployed 
systems, where no such utility exists to my knowledge).

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
