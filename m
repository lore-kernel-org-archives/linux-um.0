Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eff0W-0003OY-KO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 06:57:00 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user12889)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eff0V-0005cj-6u
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 06:57:00 -0800
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511240611.02613.rob@landley.net> (Rob Landley's message of
	"Thu, 24 Nov 2005 06:11:01 -0600")
Message-ID: <87sltkkc7i.fsf@amaterasu.srvr.nix>
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
Date: Fri, 25 Nov 2005 14:56:49 +0000
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 24 Nov 2005, Rob Landley uttered the following:
> There is a tmpfs mount, it's /dev/shm.  And apparently, even if tmpfs isn't 
> exposed as a separate filesystem, system V shared memory will still use it.

s/System V/POSIX/

It's the shm_open()/shm_close()shm_unlink() functions you're looking for.

It's been present in glibc since 2.2, so you should be able to use them
without any real difficulty if need be.

> So my question is, could system v shared memory be used in place of the tmpfs 
> mount?  (Can it be mapped in the right location and inherited across fork()?)  

You could certainly do just that with POSIX shm :)

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
