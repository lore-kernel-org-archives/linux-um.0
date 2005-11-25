Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Effd2-0005vp-FZ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 07:36:48 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user62369)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Effd1-00035L-TJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 07:36:48 -0800
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<87sltkkc7i.fsf@amaterasu.srvr.nix>
	<pqTCNcAZweUM.k//fYyReDcBiXgpOuNcx7w@sphinx.mythic-beasts.com>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <pqTCNcAZweUM.k//fYyReDcBiXgpOuNcx7w@sphinx.mythic-beasts.com>
	(Chris Lightfoot's message of "Fri, 25 Nov 2005 15:03:32 +0000")
Message-ID: <87k6ewkadb.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 25 Nov 2005 15:36:32 +0000
To: Chris Lightfoot <chris@ex-parrot.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net

On Fri, 25 Nov 2005, Chris Lightfoot murmured woefully:
> On Fri, Nov 25, 2005 at 02:56:49PM +0000, Nix wrote:
>> You could certainly do just that with POSIX shm :)
> 
> Another option is to mlock the memory, which should
> prevent paging, but requires root. I have a patch which
> does this using a helper binary, if people would like it.

Well, mlocking it is certainly not practical for everyone :) while
shm_open() and friends *is* practical as a general solution.

e.g., one of my more important UMLs, my firewall:

nix@loki 27 /home/nix% ps -o rss,vsz -C uml-esperi
  RSS    VSZ
34296  99788
 1468   1624
34296  99788
34296  99788
34296  99788

That's a very large RSS because I'm sshing in through it; normally it's
more like 5Mb. The host only has 128Mb RAM and does many other things as
well: mlock()ing that 99Mb into RAM would render the host almost
useless!

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
