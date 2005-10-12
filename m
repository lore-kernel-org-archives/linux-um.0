Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPXfp-0006Wb-Nj	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Oct 2005 20:53:01 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EPXfo-0006db-IB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Oct 2005 20:53:01 -0700
Received: from localhost.localdomain (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j9C5Nhri010430
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 Oct 2005 01:23:43 -0400
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510112252.51849.rob@landley.net>
Subject: [uml-devel] Getting garbage in ps, as expected...
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
Date: Tue, 11 Oct 2005 22:52:51 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Great fun.  So I'm using UML in -skas0 mode built from 2.6.13.2, and it's 
putting fun garbage in the ps display:

 7284 ?        S      0:00 [pdflush]
10480 pts/3    R      0:06 ?@???            ?   ?   ?    ???s   F?! @???{
12783 ?        S      0:00 [pdflush]
 8454 pts/3    R      0:03  @???{        " ? ???

Also, sometimes when my script hits an error and init exits, and of course the 
thing panics and exits, it doesn't actually exit.  Instead it remains alive 
spinning and eating CPU.  "killall linux" makes it stop eating CPU, but that 
leaves T threads, and when you unblock them you get the above garbage (and 
_they_ start spinning eating CPU)...

No easy way to script a cleanup for this...

Rob



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
