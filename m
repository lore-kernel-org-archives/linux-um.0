Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDYxt-00082E-A7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Apr 2004 18:13:21 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BDYxs-0007k3-Ht for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Apr 2004 18:13:20 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
In-Reply-To: <20040413212307.GA14758@mpmain>
Message-ID: <Pine.LNX.4.44.0404140305370.20676-200000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463811839-168681830-1081905195=:20676"
Subject: [uml-devel] [patch] Re: Reboot failing with file locked,
	CLONE_FILES and host kernel BUG()
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
Date: Wed, 14 Apr 2004 03:13:15 +0200 (CEST)
To: Marcin Pawlik <wapkil@op.pl>
Cc: user-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-168681830-1081905195=:20676
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 13 Apr 2004, Marcin Pawlik wrote:

> #v+
> F_SETLK failed, file already locked by pid 32589
> Failed to lock 'fs', err = 11
> #v-

Have been plauged by this quite a lot.. tried to narrow it down the other
day but the conclusion was that the host fcntl locking implementation is
buggy and stale locks easily gets left behind even after application has
closed the file or even terminated. Probably related to the use of clone()
which somewhat messes up the hosts view of which process owning the lock..

After this I gave up and rewrote this part to use flock instead of fcntl 
for locking. Seems to work much better except that locks are only local 
and does not protect from multiple stations accessing the same NFS mounted 
image..

Patch attached.

Regards
Henrik

---1463811839-168681830-1081905195=:20676
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="uml-flock.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0404140313150.20676@filer.marasystems.com>
Content-Description: 
Content-Disposition: attachment; filename="uml-flock.patch"

SW5kZXg6IGFyY2gvdW0vb3MtTGludXgvZmlsZS5jDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3QvdXNlci1tb2RlLWxpbnV4
L2xpbnV4L2FyY2gvdW0vb3MtTGludXgvZmlsZS5jLHYNCnJldHJpZXZpbmcg
cmV2aXNpb24gMS4yOQ0KZGlmZiAtdSAtcjEuMjkgZmlsZS5jDQotLS0gYXJj
aC91bS9vcy1MaW51eC9maWxlLmMJNyBBcHIgMjAwNCAyMDo0NDo0OSAtMDAw
MAkxLjI5DQorKysgYXJjaC91bS9vcy1MaW51eC9maWxlLmMJMTQgQXByIDIw
MDQgMDA6NDE6MjIgLTAwMDANCkBAIC02ODgsNiArNjg4LDcgQEANCiANCiBp
bnQgb3NfbG9ja19maWxlKGludCBmZCwgaW50IGV4Y2wpDQogew0KKyNpZiBV
U0VfRkNOVExfTE9DSw0KIAlpbnQgdHlwZSA9IGV4Y2wgPyBGX1dSTENLIDog
Rl9SRExDSzsNCiAJc3RydWN0IGZsb2NrIGxvY2sgPSAoKHN0cnVjdCBmbG9j
aykgeyAubF90eXBlCT0gdHlwZSwNCiAJCQkJCSAgICAgIC5sX3doZW5jZQk9
IFNFRUtfU0VULA0KQEAgLTcxMCw2ICs3MTEsMjEgQEANCiAJZXJyID0gc2F2
ZTsNCiAgb3V0Og0KIAlyZXR1cm4oZXJyKTsNCisjZWxzZQ0KKwlpbnQgdHlw
ZSA9IGV4Y2wgPyBMT0NLX0VYIDogTE9DS19TSDsNCisJaW50IGVyciwgc2F2
ZTsNCisNCisJZXJyID0gZmxvY2soZmQsIHR5cGUgfCBMT0NLX05CKTsNCisJ
aWYoIWVycikNCisJCWdvdG8gb3V0Ow0KKw0KKwlzYXZlID0gLWVycm5vOw0K
Kw0KKwlwcmludGsoImZpbGUgYWxyZWFkeSBsb2NrZWRcbiIpOw0KKwllcnIg
PSBzYXZlOw0KKyBvdXQ6DQorCXJldHVybihlcnIpOw0KKyNlbmRpZg0KIH0N
CiANCiBpbnQgb3NfZnRydW5jYXRlKGludCBmZCwgX191NjQgc2l6ZSkNCg==
---1463811839-168681830-1081905195=:20676--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
