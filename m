Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfnH3-0004ik-1G for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 15:46:37 -0800
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EfnH0-00054d-OI
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 15:46:37 -0800
From: Chris Lightfoot <chris@ex-parrot.com>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
Message-ID: <F7Gh6QjS+CQJ.VbbzsRXr69warfFBfetWCw@sphinx.mythic-beasts.com>
References: <200511240611.02613.rob@landley.net>
	<200511251003.42328.rob@landley.net>
	<87k6ewikte.fsf@amaterasu.srvr.nix>
	<200511251418.43866.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511251418.43866.rob@landley.net>
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
Date: Fri, 25 Nov 2005 23:46:31 +0000
To: Rob Landley <rob@landley.net>
Cc: Nix <nix@esperi.org.uk>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Nov 25, 2005 at 02:18:43PM -0600, Rob Landley wrote:
> Using /tmp for anything has been kind of discouraged for a while, because 
> throwing any insufficiently randomized filename in there is a security hole 
> waiting to happen.

Which case are you worried about here? SFAIK all the
filesystems anyone is likely to mount on /tmp implement
O_EXCL correctly, and in any case (as was remarked
elsewhere) there's always mkdir.

-- 
Sudden death syndrome, eh?
Sounds nasty.
What are the symptoms?              (seen on the internet)


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
