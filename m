Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYpuX-00086F-Uf for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 10:06:05 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CYpuW-00077p-QL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 10:06:05 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <267988DEACEC5A4D86D5FCD780313FBB021BB9B1@exch-03.noida.hcltech.com>
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB021BB9B1@exch-03.noida.hcltech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411291909.05952.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] /etc/shadow problem
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
Date: Mon, 29 Nov 2004 19:09:05 +0100
To: user-mode-linux-user@lists.sourceforge.net
Cc: "Adil Mujeeb, Noida" <adilm@hcltech.com>, user-mode-linux-devel@lists.sourceforge.net

On Monday 29 November 2004 16:45, Adil  Mujeeb, Noida wrote:
> Hi,
> im trying to change the user password to empty. On normal linux u can do it
> by making the password field empty in /etc/shadow file. But when im trying
> to do on UML, it doesnt update and give message login incorrect. How to
> make it empty??
Depends on the root_fs distro - the "passwd" command should always work, 
except on the toms root fs - it rewrites /etc/passwd on each shutdown (I 
don't remember exactly where).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
