Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ET0bF-0000Xn-8m	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 10:22:37 -0700
Received: from kempelen.iit.bme.hu ([152.66.241.120])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ET0bD-0003ST-Jy
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 10:22:37 -0700
Received: from localhost (pts@localhost)j9LHMNV19379
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 Oct 2005 19:22:23 +0200 (MET DST)
From: Szabo Peter <pts@inf.bme.hu>
Message-ID: <Pine.GSO.4.63.0510211919010.18944@kempelen.iit.bme.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-559023410-758783491-1129915343=:18944"
Subject: [uml-devel] hostfs link count bug?
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
Date: Fri, 21 Oct 2005 19:22:23 +0200 (MET DST)
To: user-mode-linux-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-758783491-1129915343=:18944
Content-Type: TEXT/PLAIN; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by kempelen.iit.bme.hu id
	j9LHMNV19379

Hi!

I think I have found a bug in UML. Inside my guest Linux, I get

# ls -l /etc/passwd
-rw-r--r--  18 root root 801 Oct 21 13:04 /etc/passwd
root@um-server:/dev# ls -l /etc/passwd
-rw-r--r--  19 root root 801 Oct 21 13:04 /etc/passwd
root@um-server:/dev# ls -l /etc/passwd
-rw-r--r--  20 root root 801 Oct 21 13:04 /etc/passwd
root@um-server:/dev# ls -l /etc/passwd
-rw-r--r--  21 root root 801 Oct 21 13:04 /etc/passwd
root@um-server:/dev# ls -l /etc/passwd
-rw-r--r--  22 root root 801 Oct 21 13:04 /etc/passwd
root@um-server:/dev# ls -l /etc/passwd
-rw-r--r--  23 root root 801 Oct 21 13:04 /etc/passwd

This is wrong, because the link count of /etc/passwd is incremented each=20
time ls(1) is run. This also breaks the `useradd' and `adduser' programs,=
=20
because they use a file locking method which involves checking the=20
link count.

I use this version of UML:

# dpkg -l user-mode-linux
Desired=3DUnknown/Install/Remove/Purge/Hold
| Status=3DNot/Installed/Config-files/Unpacked/Failed-config/Half-install=
ed
|/ Err?=3D(none)/Hold/Reinst-required/X=3Dboth-problems (Status,Err:=20
uppercase=3Dbad)
||/ Name           Version        Description
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ii  user-mode-linu 2.4.26-3um-1   User-mode Linux (kernel)

Best regards,

P=E9ter

--- (vvv use GNU); pts@inf.bme.hu; http://www.inf.bme.hu/~pts
[/dlflg/=3Du]dZ[lflglblp*lqlg*+lpla*lqlf*+sfsgsbdsalblex]dscZ[lb%O]sdzzKs=
a
[nlaldx*lflg%O*sfdsalblex]dsuZ[.]zsqsssgsbnsfspselsn[lcxsslqdlp+spz+sqdx]=
dx
---559023410-758783491-1129915343=:18944--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
