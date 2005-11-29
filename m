Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eh36Q-0001HC-OX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 02:52:50 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user77435)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eh36P-0000qf-5F
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 02:52:51 -0800
Subject: Re: [uml-devel] Fun little detail about /dev/shm.
References: <200511280744.09325.rob@landley.net>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511280744.09325.rob@landley.net> (Rob Landley's message of
	"Mon, 28 Nov 2005 07:44:08 -0600")
Message-ID: <87y837ybd5.fsf@amaterasu.srvr.nix>
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
Date: Tue, 29 Nov 2005 10:52:38 +0000
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, 28 Nov 2005, Rob Landley prattled cheerily:
> If you're using udev, then /dev is tmpfs.  So /dev/shm is trivially tmpfs.

True enough; but some people mount /dev with a size of 0. (Admittedly if
they don't want to break POSIX shm they'd better damn well mount *another*
tmpfs on /dev/shm with a saner size limit...)

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
