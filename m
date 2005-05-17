Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYBZ2-0006wk-Vz	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 16:33:28 -0700
Received: from rproxy.gmail.com ([64.233.170.201])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYBZ1-0006TI-FG	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 16:33:28 -0700
Received: by rproxy.gmail.com with SMTP id j1so1276190rnf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 May 2005 16:33:26 -0700 (PDT)
Message-ID: <3524bf1f0505171633edddc7@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Subject: [uml-devel] copy_from_user in SKAS mode
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
Date: Tue, 17 May 2005 19:33:26 -0400
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

i'm trying to understand how copy_from_user (and copy_to_user) is
working in SKAS mode. i started from copy_from_user_skas, and followed
the functions. but i kinda got lost and couldn't get the intuition how
data are transferred to the UML kernel, which is a different process.
Could anyone explain how copy_from_user works in SKAS mode? i'd really
appreciate it. Thank you!


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_idt12&alloc_id=16344&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
