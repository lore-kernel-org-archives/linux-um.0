Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFHSL-0005nI-LT for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Apr 2004 11:55:53 -0700
Received: from goliath.nmsrv.com ([69.28.204.18] helo=mail.praize.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BFHSL-000283-J6 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Apr 2004 11:55:53 -0700
Message-ID: <20040418185548.22259.qmail@praize.com>
From: "gboutwel" <gboutwel@praize.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Problems with the SKAS patch and 2.6
Content-Type: multipart/mixed;
 boundary="------------1082314548AEP22717"
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
Date: 18 Apr 2004 18:55:48 -0000
To: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------1082314548AEP22717
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> There is a separate version which can be applied like the old
one, i.e. onto 

> the kernel + UML patch, in the main UML page.

> 

> I applied your slight change to this 2nd version and attached
the result - 

> test at least if it applies correctly (this one goes onto the
UML patch).



BlaisorBlade,



I tried this patch.  I'm able to compile the host fine, but I've

attached what happens when I try to compile the uml guest.



The steps.



tar jxf linux-2.6.5.tar.bz2

mv linux-2.6.5 linux-2.6.6-rc1

cd linux-2.6.6-rc1

bzcat ~/2.6.4/uml-patch-2.6.4-1.tar.bz2 | patch -p1

cat ~/2.6.6/host+Uml-skas3-2.6.6-rc1-v1.patch | patch -p1

cp ~/2.6.5/config-2.6.5-uml .config

make oldconfig ARCH=um

// I had to modify /arch/um/Makefile-i386 to add the word basic

// after scripts/ like before on 2.6.5

make linux ARCH=um



During the mk_kernel_constants.o, it erros complaining about

a bunch of undefines.



Maybe I'm missing a step or something?



The 2.6.6-rc1 host is doing good though.



George









------------------------------------------

Praize? The all-in-one Christian Community

http://www.praize.com/

--------------1082314548AEP22717
Content-Type: ;
 name="uml-2.6.6-rc1.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="uml-2.6.6-rc1.log"

ICBIT1NUQ0MgIGFyY2gvdW0vc3lzLWkzODYvdXRpbC9ta19zYwogIENISyAgICAgYXJjaC91bS9p
bmNsdWRlL3N5c2RlcC1pMzg2L3NjLmgKICBVUEQgICAgIGFyY2gvdW0vaW5jbHVkZS9zeXNkZXAt
aTM4Ni9zYy5oCiAgQ0hLICAgICBhcmNoL3VtL2luY2x1ZGUvdW1sLWNvbmZpZy5oCiAgVVBEICAg
ICBhcmNoL3VtL2luY2x1ZGUvdW1sLWNvbmZpZy5oCiAgSE9TVENDICBhcmNoL3VtL3V0aWwvbWtf
Y29uc3RhbnRzX2tlcm4ubwphcmNoL3VtL3V0aWwvbWtfY29uc3RhbnRzX2tlcm4uYzogSW4gZnVu
Y3Rpb24gYG1haW4nOgphcmNoL3VtL3V0aWwvbWtfY29uc3RhbnRzX2tlcm4uYzoxNjogZXJyb3I6
IGBLRVJOX0VNRVJHJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKYXJj
aC91bS91dGlsL21rX2NvbnN0YW50c19rZXJuLmM6MTY6IGVycm9yOiAoRWFjaCB1bmRlY2xhcmVk
IGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlCmFyY2gvdW0vdXRpbC9ta19jb25zdGFu
dHNfa2Vybi5jOjE2OiBlcnJvcjogZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbi4pCmFy
Y2gvdW0vdXRpbC9ta19jb25zdGFudHNfa2Vybi5jOjE3OiBlcnJvcjogYEtFUk5fQUxFUlQnIHVu
ZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQphcmNoL3VtL3V0aWwvbWtfY29u
c3RhbnRzX2tlcm4uYzoxODogZXJyb3I6IGBLRVJOX0NSSVQnIHVuZGVjbGFyZWQgKGZpcnN0IHVz
ZSBpbiB0aGlzIGZ1bmN0aW9uKQphcmNoL3VtL3V0aWwvbWtfY29uc3RhbnRzX2tlcm4uYzoxOTog
ZXJyb3I6IGBLRVJOX0VSUicgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24p
CmFyY2gvdW0vdXRpbC9ta19jb25zdGFudHNfa2Vybi5jOjIwOiBlcnJvcjogYEtFUk5fV0FSTklO
RycgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCmFyY2gvdW0vdXRpbC9t
a19jb25zdGFudHNfa2Vybi5jOjIxOiBlcnJvcjogYEtFUk5fTk9USUNFJyB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKYXJjaC91bS91dGlsL21rX2NvbnN0YW50c19rZXJu
LmM6MjI6IGVycm9yOiBgS0VSTl9JTkZPJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBm
dW5jdGlvbikKYXJjaC91bS91dGlsL21rX2NvbnN0YW50c19rZXJuLmM6MjM6IGVycm9yOiBgS0VS
Tl9ERUJVRycgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCmFyY2gvdW0v
dXRpbC9ta19jb25zdGFudHNfa2Vybi5jOjI1OiBlcnJvcjogYE5TRUNfUEVSX1NFQycgdW5kZWNs
YXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCm1ha2VbMV06ICoqKiBbYXJjaC91bS91
dGlsL21rX2NvbnN0YW50c19rZXJuLm9dIEVycm9yIDEKbWFrZTogKioqIFthcmNoL3VtL3V0aWxd
IEVycm9yIDIKDQ==
--------------1082314548AEP22717--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
