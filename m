Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <antivano@cisco.com>) id 1WJJDc-0006Rj-OV
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Feb 2014 08:54:56 +0000
Received: from alln-iport-1.cisco.com ([173.37.142.88])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WJJDb-0004oh-KW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Feb 2014 08:54:56 +0000
From: "Anton Ivanov (antivano)" <antivano@cisco.com>
Date: Fri, 28 Feb 2014 08:54:48 +0000
Message-ID: <53104ED5.10007@cisco.com>
References: <53104888.8040404@cisco.com> <531049CD.7050502@nod.at>
In-Reply-To: <531049CD.7050502@nod.at>
Content-Language: en-US
Content-Type: multipart/mixed; boundary="_003_53104ED510007ciscocom_"
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Contribution - Bug fixes and contributions to UML
To: Richard Weinberger <richard@nod.at>
Cc: "jdike@addtoit.com" <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--_003_53104ED510007ciscocom_
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <23F8DA713ADBD04BB6962E3861A63749@emea.cisco.com>
Content-Transfer-Encoding: quoted-printable

Bugfixes.

I need to pull actual changesets for the drivers, etc properly and
verify that they build so those will be coming next week. You will be
getting them one by one.

1. Memory corruption.

The reverse case of this race (you need to msync, before you do non-mmap
fileops) is well known and textbook. This is the first and only time I
have seen this one (fsync before mmap). I have not heard it mentioned
either. It is however fairly easy to reproduce. If you run 200+ UML on a
system ~0.2-0.5% will always die at startup with a memory corruption
warning. While this does not happen every time (0.2-0.5% and only on
startup) it is very reproducible for systems running lots of UMLs.

Once this fix went in we stopped seeing that one. Observed on 3.2, 3.3
and 3.8, fix tested on 3.2, 3.3, 3.4 and 3.8.

2. SIGPIPE.

Linux actually produces SIGPIPE ane EPIPE not only on missing reader. It
will produce it under some circumstances on a stalled reader. Discovered
when running UML under expect and/or trying to use fds and other virtual
serials to do management transactions.

While I have  not seen it on UML internal pipes I would not be surprised
if you can reproduce it there too (f.e. if ubd thread is too slow). So
SIGPIPE needs to be disabled. From there on, for most drivers have
correct error handling for this.

Observed on 3.2, 3.3 and 3.8, fix tested on 3.2, 3.3, 3.4 and 3.8.

A.


On 28/02/14 08:33, Richard Weinberger wrote:
> Am 28.02.2014 09:27, schrieb Anton Ivanov (antivano):
>> Hi Richard, Hi Jeff, hi list,
>>
>> On behalf of Cisco systems, I am authorized to make a offer a set bug
>> fixes as well as contribute several additional features and performance
>> improvements to UML. All of these have been used internally for a couple
>> of years and will ship as parts of product(s) in the near future. Some
>> of these improve performance by up to 8 times on use cases which are of
>> interest to us and are likely to be of interest to the community.
>>
>> As the full patchset is now in the 100k+ zone, so I am going to do only
>> the announcement now and submit the patches one by one after that over
>> the next 1-2 weeks.
>>
>> We will submit separately bug fixes for:
>>
>> 1. Critical memory corruption on startup observed on heavily loaded
>> machines (especially when multiple UMLs run simultaneously).
>> 2. Fix(es) for incorrect handling of error conditions when UML is run
>> under expect and conX=3Dfd: is used to communicate with another process.
>> The same error may be observed on internal UML IPCs too leading to
>> immediate crash.
>>
>> I will also file bugs for both vs Debian UML package so that patches for
>> both can go in ASAP.
>>
>> In addition to the bug fixes, the new features include:
>>
>> 1. Several transports. All can do up to multi-gigabit throughput on some
>> scenarios. We are contributing their counterparts to qemu/kvm as well.
>>
>> 1.1. Direct connection of UML to overlay networks/L2 VPNs using L2TPv3.
>>
>> This has a number of advantages compared to the existing UML "multicast"
>> and qemu "socket" transports.
>>
>>     * Standard compliant - RFC 3931 updated recently by RFC 5641
>>     * Supported on most network equipment
>>     * Allowing to move virtual switching off-host to an NPU or high
>> performance physical switch
>>     * Allowing to mix virtual and physical switching (well supported on
>> modern Linuxes and other OSes)
>>     * Well researched security profile as well as established
>> interactions with IPSEC allowing to extend virtual networks outside the
>> datacenter to remote physical devices and/or VMs.
>>
>> 1.2. Raw transport which allows both bi-directional communication with
>> any network device which looks like Ethernet as well as in-span
>> listening at speeds in the multi-gigabit range.
>>
>> 1.3. We intend to contribute other key overlay transports like GRE, etc
>> as well. The ones we are contributing at this point are the ones which
>> we have used most extensively and have had the most testing (~ 1.5-2 yea=
rs).
>>
>> 2. New high res timer subsystem
>>
>> Adding these new network transports to UML revealed a key issue - it
>> cannot meter or shape any traffic correctly as its internal timer system
>> is way off. Personally, I consider it a bug, however there is no "easy"
>> fix here. The only way to fix it is a new timer driver. Unfortunately,
>> it does not fix uml userspace - timers there remain off. It does fix all
>> kernel timer functionality - traffic shaping (both qdisc and iptables
>> traffic limits).
>>
>> As a side effect, this provides performance improvements for tcp and
>> other protocols which rely on kernel high res timers for their state
>> machines.
>>
>> We have further scalability contributions lined up which improve network
>> and IO performance between 1.5 and 8 times (depending on use case),
>> allow hundreds of virtual interfaces per UML without performance
>> penalties, allow to run several hundreds (if not thousands) of UMLs per
>> machine, etc. All in all, it can no go where no virtualization and no
>> virtual networking has gone before.
>>
>> However, I would prefer to take it one step at a time and get through
>> these first (even these are quite a lot for one "sitting").
> Sounds awesome!
>
> Please send the patches as soon as possible.
> I'm eager to test and merge them.
>
> Thanks,
> //richard


--_003_53104ED510007ciscocom_
Content-Type: text/x-patch; name="sigpipe.diff"
Content-Description: sigpipe.diff
Content-Disposition: attachment; filename="sigpipe.diff"; size=334;
	creation-date="Fri, 28 Feb 2014 08:54:48 GMT";
	modification-date="Fri, 28 Feb 2014 08:54:48 GMT"
Content-ID: <D034D5495F63D54EADF744FBA5AD1B11@emea.cisco.com>
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvdW0vb3MtTGludXgvbWFpbi5jIGIvYXJjaC91bS9vcy1MaW51eC9t
YWluLmMNCmluZGV4IDdhODZkZDUuLjA0ODE2NmQgMTAwNjQ0DQotLS0gYS9hcmNoL3VtL29zLUxp
bnV4L21haW4uYw0KKysrIGIvYXJjaC91bS9vcy1MaW51eC9tYWluLmMNCkBAIC0xNDksNiArMTQ5
LDcgQEAgaW50IF9faW5pdCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndiwgY2hhciAqKmVudnAp
DQogI2VuZGlmDQogDQogCWRvX3VtbF9pbml0Y2FsbHMoKTsNCisJY2hhbmdlX3NpZyhTSUdQSVBF
LCAwKTsNCiAJcmV0ID0gbGludXhfbWFpbihhcmdjLCBhcmd2KTsNCiANCiAJLyoNCg==

--_003_53104ED510007ciscocom_
Content-Type: text/x-patch; name="memory-corruption.diff"
Content-Description: memory-corruption.diff
Content-Disposition: attachment; filename="memory-corruption.diff"; size=2258; 
	creation-date="Fri, 28 Feb 2014 08:54:48 GMT";
	modification-date="Fri, 28 Feb 2014 08:54:48 GMT"
Content-ID: <AD79FB295676E24DAC30BBAB637FF971@emea.cisco.com>
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvdW0vaW5jbHVkZS9zaGFyZWQvb3MuaCBiL2FyY2gvdW0vaW5jbHVk
ZS9zaGFyZWQvb3MuaA0KaW5kZXggYjMxNGNmNy4uZTk4NGIyYyAxMDA2NDQNCi0tLSBhL2FyY2gv
dW0vaW5jbHVkZS9zaGFyZWQvb3MuaA0KKysrIGIvYXJjaC91bS9pbmNsdWRlL3NoYXJlZC9vcy5o
DQpAQCAtMTQ0LDYgKzE0NCw3IEBAIGV4dGVybiBpbnQgb3Nfd3JpdGVfZmlsZShpbnQgZmQsIGNv
bnN0IHZvaWQgKmJ1ZiwgaW50IGNvdW50KTsNCiBleHRlcm4gaW50IG9zX2ZpbGVfc2l6ZShjb25z
dCBjaGFyICpmaWxlLCB1bnNpZ25lZCBsb25nIGxvbmcgKnNpemVfb3V0KTsNCiBleHRlcm4gaW50
IG9zX2ZpbGVfbW9kdGltZShjb25zdCBjaGFyICpmaWxlLCB1bnNpZ25lZCBsb25nICptb2R0aW1l
KTsNCiBleHRlcm4gaW50IG9zX3BpcGUoaW50ICpmZCwgaW50IHN0cmVhbSwgaW50IGNsb3NlX29u
X2V4ZWMpOw0KK2V4dGVybiBpbnQgb3NfZnN5bmMoaW50IGZkKTsNCiBleHRlcm4gaW50IG9zX3Nl
dF9mZF9hc3luYyhpbnQgZmQpOw0KIGV4dGVybiBpbnQgb3NfY2xlYXJfZmRfYXN5bmMoaW50IGZk
KTsNCiBleHRlcm4gaW50IG9zX3NldF9mZF9ibG9jayhpbnQgZmQsIGludCBibG9ja2luZyk7DQpk
aWZmIC0tZ2l0IGEvYXJjaC91bS9rZXJuZWwvcGh5c21lbS5jIGIvYXJjaC91bS9rZXJuZWwvcGh5
c21lbS5jDQppbmRleCBmMTE2ZGIxLi5lYTYwNmVlIDEwMDY0NA0KLS0tIGEvYXJjaC91bS9rZXJu
ZWwvcGh5c21lbS5jDQorKysgYi9hcmNoL3VtL2tlcm5lbC9waHlzbWVtLmMNCkBAIC04Nyw2ICs4
NywxNCBAQCB2b2lkIF9faW5pdCBzZXR1cF9waHlzbWVtKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVu
c2lnbmVkIGxvbmcgcmVzZXJ2ZV9lbmQsDQogDQogCXBoeXNtZW1fZmQgPSBjcmVhdGVfbWVtX2Zp
bGUobGVuICsgaGlnaG1lbSk7DQogDQorCS8qDQorCSAqIFNwZWNpYWwga2x1ZGdlIC0gVGhpcyBw
YWdlIHdpbGwgYmUgbWFwcGVkIGluIHRvIHVzZXJzcGFjZSBwcm9jZXNzZXMNCisJICogZnJvbSBw
aHlzbWVtX2ZkLCBzbyBpdCBuZWVkcyB0byBiZSB3cml0dGVuIG91dCB0aGVyZS4NCisJICovDQor
CW9zX3NlZWtfZmlsZShwaHlzbWVtX2ZkLCBfX3BhKCZfX3N5c2NhbGxfc3R1Yl9zdGFydCkpOw0K
Kwlvc193cml0ZV9maWxlKHBoeXNtZW1fZmQsICZfX3N5c2NhbGxfc3R1Yl9zdGFydCwgUEFHRV9T
SVpFKTsNCisgICAgICAgIG9zX2ZzeW5jKHBoeXNtZW1fZmQpOw0KKw0KIAlvZmZzZXQgPSB1bWxf
cmVzZXJ2ZWQgLSB1bWxfcGh5c21lbTsNCiAJZXJyID0gb3NfbWFwX21lbW9yeSgodm9pZCAqKSB1
bWxfcmVzZXJ2ZWQsIHBoeXNtZW1fZmQsIG9mZnNldCwNCiAJCQkgICAgbGVuIC0gb2Zmc2V0LCAx
LCAxLCAxKTsNCkBAIC05NywxMiArMTA1LDYgQEAgdm9pZCBfX2luaXQgc2V0dXBfcGh5c21lbSh1
bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIHJlc2VydmVfZW5kLA0KIAkJZXhpdCgx
KTsNCiAJfQ0KIA0KLQkvKg0KLQkgKiBTcGVjaWFsIGtsdWRnZSAtIFRoaXMgcGFnZSB3aWxsIGJl
IG1hcHBlZCBpbiB0byB1c2Vyc3BhY2UgcHJvY2Vzc2VzDQotCSAqIGZyb20gcGh5c21lbV9mZCwg
c28gaXQgbmVlZHMgdG8gYmUgd3JpdHRlbiBvdXQgdGhlcmUuDQotCSAqLw0KLQlvc19zZWVrX2Zp
bGUocGh5c21lbV9mZCwgX19wYSgmX19zeXNjYWxsX3N0dWJfc3RhcnQpKTsNCi0Jb3Nfd3JpdGVf
ZmlsZShwaHlzbWVtX2ZkLCAmX19zeXNjYWxsX3N0dWJfc3RhcnQsIFBBR0VfU0laRSk7DQogDQog
CWJvb3RtYXBfc2l6ZSA9IGluaXRfYm9vdG1lbShwZm4sIHBmbiArIGRlbHRhKTsNCiAJZnJlZV9i
b290bWVtKF9fcGEocmVzZXJ2ZV9lbmQpICsgYm9vdG1hcF9zaXplLA0KZGlmZiAtLWdpdCBhL2Fy
Y2gvdW0vb3MtTGludXgvZmlsZS5jIGIvYXJjaC91bS9vcy1MaW51eC9maWxlLmMNCmluZGV4IGIw
NDlhNjMuLmQ0OTg1YmU5OSAxMDA2NDQNCi0tLSBhL2FyY2gvdW0vb3MtTGludXgvZmlsZS5jDQor
KysgYi9hcmNoL3VtL29zLUxpbnV4L2ZpbGUuYw0KQEAgLTMzLDYgKzMzLDEwIEBAIHN0YXRpYyB2
b2lkIGNvcHlfc3RhdChzdHJ1Y3QgdW1sX3N0YXQgKmRzdCwgY29uc3Qgc3RydWN0IHN0YXQ2NCAq
c3JjKQ0KIAl9KTsNCiB9DQogDQoraW50IG9zX2ZzeW5jKGludCBmZCkgew0KKyAgIGZzeW5jKGZk
KTsNCit9DQorDQogaW50IG9zX3N0YXRfZmQoY29uc3QgaW50IGZkLCBzdHJ1Y3QgdW1sX3N0YXQg
KnVidWYpDQogew0KIAlzdHJ1Y3Qgc3RhdDY0IHNidWY7DQo=

--_003_53104ED510007ciscocom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
--_003_53104ED510007ciscocom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--_003_53104ED510007ciscocom_--


