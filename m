Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKOxj-000723-GY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Oct 2004 15:29:43 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CKOxi-0003YM-Lk for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Oct 2004 15:29:43 -0700
Message-ID: <053e01c4b6f4$93f48e90$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] UML "Distro" ?
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
Date: Thu, 21 Oct 2004 00:31:43 +0200
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Hi folks, 

I would like to hear your opinion if it`s worth thinking about a "UML Linux Distribution".

It could be based on another distro (debian? fedora?) and contain:

- A setup for installation of a minimalistic, UML-"ready" base system - call it a "UML 
  runtime environment". That means: Recent and skas/sysemu-patched kernel(2.6), modules, 
  X, uml-utilities, screen, scripts, bridge-utils......
- Pre-configured environment (bridge setup,tmpfs,mountpoints...)
- some UML kernels
- basic root-filesystems "ready to run"

This could be valuable to people who want to get UML run quickly at good performance or want 
to roll it out in larger environments

What do you think ?

( ) Ohhhh - nooooo, not another Distro!
( ) probably useful to make setup/usage of UML easier
( ) becoming useless, if skas/sysemu go into vanilla kernel

:)

regards
Roland




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
