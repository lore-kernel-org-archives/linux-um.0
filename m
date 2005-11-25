Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eff6y-0003t2-IX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 07:03:40 -0800
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eff6x-00051y-Ak
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 07:03:40 -0800
From: Chris Lightfoot <chris@ex-parrot.com>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
Message-ID: <pqTCNcAZweUM.k//fYyReDcBiXgpOuNcx7w@sphinx.mythic-beasts.com>
References: <200511240611.02613.rob@landley.net>
	<87sltkkc7i.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sltkkc7i.fsf@amaterasu.srvr.nix>
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
Date: Fri, 25 Nov 2005 15:03:32 +0000
To: Nix <nix@esperi.org.uk>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Nov 25, 2005 at 02:56:49PM +0000, Nix wrote:
> You could certainly do just that with POSIX shm :)

Another option is to mlock the memory, which should
prevent paging, but requires root. I have a patch which
does this using a helper binary, if people would like it.

-- 
``As usual the Liberals offer a mixture of sound and original ideas.
  Unfortunately none of the sound ideas is original and none of the
  original ideas is sound.'' (Harold Macmillan)


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
