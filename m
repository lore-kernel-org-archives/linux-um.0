Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4MTB-0008DZ-Ey for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Mar 2004 08:03:37 -0800
Received: from the-doors.enix.org ([62.210.169.120])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4MTA-0003a2-Ub for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Mar 2004 08:03:37 -0800
From: sw+uml@enix.org
Message-ID: <20040319160412.GA11573@the-doors.enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Subject: [uml-devel] Symbol __generic_copy_to_user ?
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
Date: Fri, 19 Mar 2004 17:04:12 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

I'm currently trying to run "changedfiles" which has a custom kernel module,
but it failed as the symbol "__generic_copy_to_user" is not exported in my
uml build.

The module only run on a 2.4 kernel.

Does someone has a solution ?


Wacquiez S=E9bastien

PS : Please forgive my for my bad english, and CC me to your reply as I'm
not subscribed to this list (sw+uml@enix.org))


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
