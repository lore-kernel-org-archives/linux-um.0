Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAzEm-0007ei-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sat, 18 Oct 2003 15:07:52 -0700
Received: from [80.254.131.106] (helo=shell.blacknet.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAzCY-0004Ls-9n
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 18 Oct 2003 15:05:34 -0700
From: Goetz Bock <bock@blacknet.de>
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
Message-ID: <20031018215745.GK441@shell.blacknet.de>
References: <BAY7-F71MKk9LqOVoQc000091eb@hotmail.com> <Pine.LNX.4.44.0310181435400.30746-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310181435400.30746-100000@filer.marasystems.com>
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
Date: Sat, 18 Oct 2003 23:57:45 +0200
To: User-mode-linux-devel@lists.sourceforge.net



--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Sat, Oct 18 '03 at 14:37, Henrik Nordstrom wrote:
> > It would be nice if a chroot wrapper could open the files and pass the 
> > "filemap=" config strings to your config parser.  Something like this:
> 
> What I do not quite get in this discussion is why one does not want to
> have the selected files available in the chroot in the first place?
> 
> To chroot you need to be root. As root you are also allowed to map files
> around using mount --bind.
No, there is no need to be root inside a chrooted environment, or better
yet you should not be.

I've created a patch to su (from coreutils) to allow root to chroot into
a given directory, than su to a user, and execute a binary (attached).

My uml setup for an uml instance includeds a /bin/ directory for each
user with one copy of the uml instance, the commandline than looks like
this

su -r /home/uml/utest utest -s /bin/utest  umid=utest ...

where utest is a user on the host.
-- 
/"\ Goetz Bock at blacknet dot de  --  secure mobile Linux everNETting
\ /                     (c) 2003 as GNU FDL 1.1
 X   [ 1. Use descriptive subjects - 2. Edit a reply for brevity -  ]
/ \  [ 3. Reply to the list - 4. Read the archive *before* you post ]

--x+6KMIRAuhnl3hBn
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="coreutils-5.0-su-chroot.patch.gz"
Content-Transfer-Encoding: base64

H4sICCul/z4AA2NvcmV1dGlscy01LjAtc3UtY2hyb290LnBhdGNoAJVWe2/aSBD/Gz7FHKcm
UNvEzgMaeqmSS7kmEgkRJPeQIlmOvYbV+XW761AU9bvfzK4dIA253oLMMq+d+c1jHfE4BqcU
1xDmgpWKJ9I56rrdXPDZXhpke7Lsepu8Z3LTcZy31Br7rnvg4PfABe9w4B0MDr2uWy+wXOQ3
LcvaYr5S75G6ezg47L2mfnoKzv4HuwcWPj0XTk+bcB//eu/I+3himy3+mbMkQcLJfXw5vRiO
Rrhvgigz0P+Ax7DHVLin5SQESZIvJHDVhO7tTdPSVsS6wXAu8lxVFq+Hf0zG41uyaRkGqBwq
KjywOBcgS57NiHw3HU66Tes6VwyWeQkpn80VzINHRtxSMnCkDYEENWcQsTgoE1V5aUQzNM++
cqnQCnlXu4SuFzqsiMsiCZZogEsgKgRZRCpVONFbKZciJPDDFzmpydtSXvNf5mx/4PV/IOXb
1A8GXu/VlPeOKeX47OuM4yLUHJPoE/1sTFbpzaRiQQR5rOHflaAlIBZ5ahJfBFIuoiY0Go0y
S5iUGmZKgSwLJjAtQqO4oc6lVhBMKsFDxSLMCHkiyBNTCCe6GnCt6mKtKNhXFiIIWBjazybo
SM7ztOAJcxRPGeSF4nkmBybGz9O/pqPxF396d34+nE4bo3yGDoYhOhyXCW7Rt/bDsq4bm86j
czuw4GoOcimTfNbVCHrHPYLQO+4/Y/jUQi7PWjYG7wdiVqYsQxvXd6ORDbvJ7jfbSBUYMROP
zGHZIxd5RmIvlXbCeZDNmL8mYoNbW9D4oYpg/5RcsGhN0cWjJB1lkaCBbbukqJ36Mrwd39z6
COONj5vL8bX/eXg+2uT+PpxMifO9gKvN0febqa99jU4Ph0qNjpNSWl+LHZlRrguGmNida6zH
QPDgASvqPrvXVgrYvmSAGcfWd9Jaeq2oTSmvrf8eX2TFelGQuvzW1mZh6nNbHRukivJSdT42
K7G4KBXW1ia+0/PJpd5vlf8O8ddUNOCHfQ34kfsMOFaQgPdhnqbUeSfgflxR3wdRxKkzgoQq
Qr5gm/7UNKumZWyhI60lsWnLUIHpfHhfLF6hFgs/zIslcoyTRzRwrF7v4NlJydMyCRTzdeus
u/Gi+pHlkR0HYDHH9oZ2G3s7RPKMKdyhAZwDbQwmxPEvZo82tMJBnKSFHGD9ExelpGnHTgd+
OsEe7lB4/9uceMugzt5TnUaJcyOcg7aNvMaTweGDSdaxZ3ueBqIBUGOOonjeR017ECz4m6K2
GmGAVxv26wD3AKtk1OLWStzCD2gFf72tzy/OJmRrk1VXGHGhfTMZf5mcXfnXZ1dDG87ubi/G
k2lVYn1X93TfO7KPq+xh41BoHOvrF0IprOL/vroIQrDACOuIjHYdCKLnws4OoV/yCNodnRpa
TAgc9e3hn5e3/m9nl6O7yVBPGr/dSkup8CqAugPp9q8mXqdDOKB6sTA5LRZZkOrzfLqNTKeR
BySAh1eev3GavsTeSZxVTK7eIqjZ14xqoI50evt4vXpH9f0K3+gnzfHtYblR1+iAbZLf2YJL
BcVTjQjxq7FTy63g2hICErPcXgmZhVGFQUaxmIYzSEZ4UYQqF0vC9J2sItTH6OJa9wJlod3a
a/2gAxsnkm51wa7ONJmrAGvCzzzGy5jeG/ybsys9MZiK8W0wQtycTzhgcIsa/wKxu/NQiAsA
AA==

--x+6KMIRAuhnl3hBn--


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
