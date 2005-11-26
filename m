Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Efwus-0001fy-QR for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 02:04:22 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Efwuq-0000td-BC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 02:04:22 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511251418.43866.rob@landley.net>
	<F7Gh6QjS+CQJ.VbbzsRXr69warfFBfetWCw@sphinx.mythic-beasts.com>
In-Reply-To: <F7Gh6QjS+CQJ.VbbzsRXr69warfFBfetWCw@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511260403.55274.rob@landley.net>
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
Date: Sat, 26 Nov 2005 04:03:54 -0600
To: Chris Lightfoot <chris@ex-parrot.com>
Cc: Nix <nix@esperi.org.uk>, user-mode-linux-devel@lists.sourceforge.net

On Friday 25 November 2005 17:46, Chris Lightfoot wrote:
> On Fri, Nov 25, 2005 at 02:18:43PM -0600, Rob Landley wrote:
> > Using /tmp for anything has been kind of discouraged for a while, because
> > throwing any insufficiently randomized filename in there is a security
> > hole waiting to happen.
>
> Which case are you worried about here? SFAIK all the
> filesystems anyone is likely to mount on /tmp implement
> O_EXCL correctly, and in any case (as was remarked
> elsewhere) there's always mkdir.

I think programmers got the general impression using /tmp for temporary files 
was a really stupid idea from the fact that it keeps cropping up on things 
like LWN's security section.  Here's the ones they linked to just last week 
as still being fixed by various distros:
http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2004-0968
http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-2672
http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2005-2851
http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-2104
http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2005-3124

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
