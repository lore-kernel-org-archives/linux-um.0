Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB021BBBDE@exch-03.noida.hcltech.com>
From: "Adil  Mujeeb, Noida" <adilm@hcltech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Subject: [uml-devel] RE: [uml-user] /etc/shadow problem
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
Date: Tue, 30 Nov 2004 09:39:18 +0530
To: Blaisorblade <blaisorblade_spam@yahoo.it>, user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net

Is it possible to make the root password empty with passwd command?? i have
tried but it gives error on empty password

Thanks and Best Regards, 
Adil Mujeeb


-----Original Message-----
From: Blaisorblade [mailto:blaisorblade_spam@yahoo.it]
Sent: Monday, November 29, 2004 11:39 PM
To: user-mode-linux-user@lists.sourceforge.net
Cc: Adil Mujeeb, Noida; user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-user] /etc/shadow problem


On Monday 29 November 2004 16:45, Adil  Mujeeb, Noida wrote:
> Hi,
> im trying to change the user password to empty. On normal linux u can do
it
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
