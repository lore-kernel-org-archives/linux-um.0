Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAu3m-0006S5-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 18 Oct 2003 09:36:10 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1AAu3W-0007CP-IT
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 18 Oct 2003 09:35:54 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it> (by way of BlaisorBlade <blaisorblade_spam@yahoo.it>)
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200310181834.50216.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 18 Oct 2003 18:34:50 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 16:08, marted=EC 14 ottobre 2003, Steve Schmidtke ha scritto:
> Doug Dumitru wrote:
> >A couple of questions.  I noticed that you are not mapping /proc/mm.
>
> [...]
>
> >This looks like one per virtual process (minus threads).  Am I reading
> > this right.
>
> yes. The discussion for a previous patch considered a "mm" table to hold a
> pool of /proc/mm files to handle one fd per process.
> [....]

Nooo! Don't make your like hard!

Search for this thread "[uml-user] chroot'ing an UML - /proc/mm" on
http://marc.theaimsgroup.com/ !
You can use mount --bind inside the host to make /proc/mm visible to UML.
 I.e. it should be something such(NOT TRIED!):

cd <chroot path>
mkdir proc
touch proc/mm #You must create the mount point. In this case it's a file.
(as root)mount --bind /proc/mm proc/mm
<start Uml binary with "# chroot . linux ...." >

About the ugliness, it's only a userspace syntax matter. This is the v2 of
 the umlwrap syntax. Instead of this:
  umlwrap -bind=3D21,/dev/shm/mconsole1 -dir=3D/home/uml -- \
  /bin/linux mem=3D48M uml_dir=3D/uml/ umid=3Dum1 filemap=3D22,/uml/um1/pid=
 \
  22</dev/shm/pid filemap=3D21,/uml/um1/mconsole

We can have this:
  umlwrap -dir=3D/home/uml -bind=3D/dev/shm/mconsole1,/uml/um1/mconsole \
  -map=3Dr,/dev/shm/pid,/uml/um1/pid-- /bin/linux mem=3D48M uml_dir=3D/uml/
 umid=3Dum1

umlwrap will then setup the needed "filemap" options, at the end of the
command line. However, does UML(unlike vanilla kernel) supports so long(>512
char) command lines in the internal kernel part, (in the userspace part it's
granted)? If not, we can use a patch out there that is already used by
Knoppix.

By the way, if umlwrap is smart enough, maybe it can guess whether to use
-map, -bind or -connect by itself(at least partially, i.e. stating the file=
).
However this isn't a problem here. And for the length of settings, there is
scripting!

Bye
--
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise=20
Linux in the Boardroom; in the Front Office; & in the Server Room=20
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
