Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALPjC-00044G-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 08:26:22 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ALPic-0008Ag-Pn
	for User-mode-linux-devel@lists.sourceforge.net; Sun, 16 Nov 2003 08:25:46 -0800
Received: from mercury.dur.ac.uk (mercury.dur.ac.uk [129.234.4.40])
	by hermes.dur.ac.uk (8.11.7-20030923/8.11.7) with ESMTP id hAGGPgS16166
	for <User-mode-linux-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 16:25:42 GMT
Received: from altair.dur.ac.uk (altair.dur.ac.uk [129.234.4.14])
	by mercury.dur.ac.uk (8.12.10+Sun/8.11.7) with ESMTP id hAGGPek6010709
	for <User-mode-linux-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 16:25:40 GMT
Received: from localhost (dit0may@localhost)
	by altair.dur.ac.uk (8.11.7+Sun/8.11.1) with ESMTP id hAGGPdJ07581
	for <User-mode-linux-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 16:25:39 GMT
From: M A Young <m.a.young@durham.ac.uk>
Message-ID: <Pine.GSO.4.58.0311161608130.5422@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1068999939=:5422"
Subject: [uml-devel] Anaconda install of a fedora core 1 uml
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
Date: Sun, 16 Nov 2003 16:25:39 +0000 (GMT)
To: User-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1068999939=:5422
Content-Type: TEXT/PLAIN; charset=US-ASCII

I have now successfully installed a uml image of Red Hat's fedora core 1
distribution using Red Hat's ordinary install process (anaconda), and
below is a brief outline of how I did it.

	Michael Young

Create a blank file to contain the root file system (600M is just too small
for a minimal install, I tried 640M). eg.
dd if=/dev/zero of=root_fs seek=655359 bs=1024 count=1
Put the fedora binary ISOs in an empty directory on the host, uncompress
and add the attached updates.img and share the directory in NFS ready for
the uml system.
Build an appropriate kernel, I choose one with options built in rather than as
modules, but with module support enabled. Boot it with extra memory specified
and a bigger than normal ramdisk (I haven't tuned these parameters), and some
network configuration.
Extract a standard initrd.img from the CD, eg. from the boot.iso image.
./linux initrd=initrd.img mem=256M ramdisk_size=10240 text noprobe + network options
Install normally.
Edit the image to put appropriate /dev/ubd... devices in.
Boot the uml system.

Notes
1. If your kernel segfaults very early on try
echo "0" >/proc/sys/kernel/exec-shield-randomize
first.
2. Ignore errors about ubdb* not existing. The isys.py in the updates.img
file manually adds the ubda and ubdb devices. A later version (if I ever
write it) will try to detect any such drives properly.
3. sda may get mentioned. This "drive" seems actually to be the first
16384 bytes of the root_fs file though I am not entirely sure why.
4. The install will probably restart shortly after partitioning, but work
the second time. This is probably this bug.
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=106216230910416&w=2
5. My install was slow because there seemed to be NFS timeouts between the
host and uml systems, though this might have been my kernel at fault.
---559023410-851401618-1068999939=:5422
Content-Type: APPLICATION/octet-stream; name="updates.img.bz2"
Content-Transfer-Encoding: BASE64
Content-Description: bzip2ed updates.img file
Content-Disposition: attachment; filename="updates.img.bz2"

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

---559023410-851401618-1068999939=:5422--


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
