Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DInLH-0001YW-MT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Apr 2005 05:39:39 -0700
Received: from motgate8.mot.com ([129.188.136.8])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DInLG-0002Zb-V6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Apr 2005 05:39:39 -0700
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id j35Cfv24015173
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 5 Apr 2005 05:41:57 -0700 (MST)
Received: from zch07exm05.corp.mot.com (ZCH07EXM05.corp.mot.com [200.3.1.211])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id j35Cf82J005886
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 5 Apr 2005 07:41:09 -0500 (CDT)
Message-ID: <3BCB5FB76AFFF646BCFBC02A889B64F302010341@ZCH07EXM05.corp.mot.com>
From: Wu Haibao-a15761 <a15761@motorola.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C539DC.85090028"
Subject: [uml-devel] gdb can not start up in UML and signal 11 issues
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
Date: Tue, 5 Apr 2005 20:39:33 +0800
To: user-mode-linux-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C539DC.85090028
Content-Type: text/plain;
	charset="GB2312"

Hi,
    I'm running UML 2.4.26 on customerized linux 2.4.21, and met the following problems which I can not figure out:
    1. gdb does not come up with a command line prompt when I add the "debug" option in the uml (in tt mode), it just hang up with these message:
================================================
GNU gdb Red Hat Linux (6.1post-1.20040607.17rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host libthread_db library "/lib/libthread_db.so.1".
================================================
        
        2. After starting UML without the debug option and running some applications, it hangs up.  I found the the tt thread is working with endless signal 11 (SIGSEGV) from an application. I just wonder why so many SIGSEGV signals are sent.  Actually after I add some log to the UML, I found  that almost every application sent SIGSEGV to tt, why this happens?
 
        Could you please give any suggestion on these?
        Thanks.
 
Regards,
Wu Haibao
 

------------------------------------------------------- 
[ ] General Business Information 
[x] Motorola Internal Use Only 
[ ] Motorola Confidential Proprietary 

 

------_=_NextPart_001_01C539DC.85090028
Content-Type: text/html;
	charset="GB2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgSFRUUC1FUVVJVj0iQ29udGVudC1UeXBlIiBDT05U
RU5UPSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9R0IyMzEyIj4NCg0KDQo8TUVUQSBjb250ZW50PSJNU0hU
TUwgNi4wMC4yODAwLjE0OTEiIG5hbWU9R0VORVJBVE9SPjwvSEVBRD4NCjxCT0RZPg0KPERJVj48
U1BBTiBjbGFzcz0wNjI0MjI5MTItMDUwNDIwMDU+PEZPTlQgZmFjZT1BcmlhbCANCnNpemU9Mj5I
aSw8L0ZPTlQ+PC9TUEFOPjwvRElWPg0KPERJVj48U1BBTiBjbGFzcz0wNjI0MjI5MTItMDUwNDIw
MDU+Jm5ic3A7Jm5ic3A7Jm5ic3A7IDxGT05UIGZhY2U9QXJpYWwgDQpzaXplPTI+SSdtIHJ1bm5p
bmcgVU1MIDIuNC4yNiBvbiBjdXN0b21lcml6ZWQgbGludXggMi40LjIxLCBhbmQgbWV0IHRoZSAN
CmZvbGxvd2luZyBwcm9ibGVtcyB3aGljaCZuYnNwO0kgY2FuIG5vdCBmaWd1cmUgb3V0OjwvRk9O
VD48L1NQQU4+PC9ESVY+DQo8RElWPjxTUEFOIGNsYXNzPTA2MjQyMjkxMi0wNTA0MjAwNT4mbmJz
cDsmbmJzcDsmbmJzcDsgPEZPTlQgZmFjZT1BcmlhbCANCnNpemU9Mj4xLiBnZGIgZG9lcyBub3Qg
Y29tZSB1cCB3aXRoIGEgY29tbWFuZCBsaW5lIHByb21wdCB3aGVuIEkgYWRkIHRoZSAiZGVidWci
IA0Kb3B0aW9uIGluIHRoZSB1bWwgKGluIHR0IG1vZGUpLCBpdCBqdXN0IGhhbmcgdXAgd2l0aCB0
aGVzZSANCm1lc3NhZ2U6PC9GT05UPjwvU1BBTj48L0RJVj4NCjxESVY+PFNQQU4gY2xhc3M9MDYy
NDIyOTEyLTA1MDQyMDA1PjxGT05UIGZhY2U9QXJpYWwgDQpzaXplPTI+PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PC9GT05UPjwvU1BBTj48L0RJVj4NCjxE
SVY+PFNQQU4gY2xhc3M9MDYyNDIyOTEyLTA1MDQyMDA1PjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0y
PkdOVSBnZGIgUmVkIEhhdCANCkxpbnV4ICg2LjFwb3N0LTEuMjAwNDA2MDcuMTdyaCk8QlI+Q29w
eXJpZ2h0IDIwMDQgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCANCkluYy48QlI+R0RCIGlzIGZy
ZWUgc29mdHdhcmUsIGNvdmVyZWQgYnkgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlLCBh
bmQgeW91IA0KYXJlPEJSPndlbGNvbWUgdG8gY2hhbmdlIGl0IGFuZC9vciBkaXN0cmlidXRlIGNv
cGllcyBvZiBpdCB1bmRlciBjZXJ0YWluIA0KY29uZGl0aW9ucy48QlI+VHlwZSAic2hvdyBjb3B5
aW5nIiB0byBzZWUgdGhlIGNvbmRpdGlvbnMuPEJSPlRoZXJlIGlzIGFic29sdXRlbHkgDQpubyB3
YXJyYW50eSBmb3IgR0RCLiZuYnNwOyBUeXBlICJzaG93IHdhcnJhbnR5IiBmb3IgZGV0YWlscy48
QlI+VGhpcyBHREIgd2FzIA0KY29uZmlndXJlZCBhcyAiaTM4Ni1yZWRoYXQtbGludXgtZ251Ii4u
LlVzaW5nIGhvc3QgbGlidGhyZWFkX2RiIGxpYnJhcnkgDQoiL2xpYi9saWJ0aHJlYWRfZGIuc28u
MSIuPC9GT05UPjwvU1BBTj48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQ
QU4gDQpjbGFzcz0wNjI0MjI5MTItMDUwNDIwMDU+PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFj
ZT1BcmlhbCBzaXplPTI+PFNQQU4gDQpjbGFzcz0wNjI0MjI5MTItMDUwNDIwMDU+Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KPC9TUEFOPjwvRk9OVD48L0RJVj4N
CjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gDQpjbGFzcz0wNjI0MjI5MTItMDUw
NDIwMDU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDIuIEFmdGVy
IA0Kc3RhcnRpbmcgVU1MIHdpdGhvdXQgdGhlIGRlYnVnIG9wdGlvbiBhbmQgcnVubmluZyBzb21l
IGFwcGxpY2F0aW9ucywgaXQgaGFuZ3MgDQp1cC4mbmJzcDsgSSBmb3VuZCB0aGUgdGhlIHR0IHRo
cmVhZCBpcyB3b3JraW5nIHdpdGggZW5kbGVzcyBzaWduYWwgMTEgKFNJR1NFR1YpIA0KZnJvbSBh
biBhcHBsaWNhdGlvbi4gSSBqdXN0IHdvbmRlciB3aHkgc28gbWFueSBTSUdTRUdWIHNpZ25hbHMg
YXJlIHNlbnQuJm5ic3A7IA0KQWN0dWFsbHkgYWZ0ZXIgSSBhZGQgc29tZSBsb2cgdG8gdGhlIFVN
TCwgSSBmb3VuZCZuYnNwOyB0aGF0IGFsbW9zdCBldmVyeSANCmFwcGxpY2F0aW9uIHNlbnQgU0lH
U0VHViB0byB0dCwgd2h5IHRoaXMgaGFwcGVucz88L1NQQU4+PC9GT05UPjwvRElWPg0KPERJVj48
Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiANCmNsYXNzPTA2MjQyMjkxMi0wNTA0MjAwNT48
L1NQQU4+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48
U1BBTiANCmNsYXNzPTA2MjQyMjkxMi0wNTA0MjAwNT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgQ291bGQgeW91IA0KcGxlYXNlIGdpdmUgYW55IHN1Z2dlc3Rpb24g
b24gdGhlc2U/PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXpl
PTI+PFNQQU4gDQpjbGFzcz0wNjI0MjI5MTItMDUwNDIwMDU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KVGhhbmtzLjwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElW
PjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9MDYyNDIyOTEyLTA1MDQyMDA1
PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0y
PjxTUEFOIA0KY2xhc3M9MDYyNDIyOTEyLTA1MDQyMDA1PlJlZ2FyZHMsPC9TUEFOPjwvRk9OVD48
L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gY2xhc3M9MDYyNDIyOTEy
LTA1MDQyMDA1Pld1IA0KSGFpYmFvPC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PFNQQU4gY2xh
c3M9MDYyNDIyOTEyLTA1MDQyMDA1PjxGT05UIGZhY2U9QXJpYWwgDQpzaXplPTI+PC9GT05UPjwv
U1BBTj4mbmJzcDs8L0RJVj4NCjxQPjxGT05UIGZhY2U9QXJpYWwgDQpzaXplPTI+LS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTwvRk9OVD4gPEJS
PjxGT05UIA0KZmFjZT1BcmlhbCBzaXplPTI+WyBdIEdlbmVyYWwgQnVzaW5lc3MgSW5mb3JtYXRp
b248L0ZPTlQ+IDxCUj48Rk9OVCBmYWNlPUFyaWFsIA0Kc2l6ZT0yPlt4XSBNb3Rvcm9sYSBJbnRl
cm5hbCBVc2UgT25seTwvRk9OVD4gPEJSPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPlsgXSANCk1v
dG9yb2xhIENvbmZpZGVudGlhbCBQcm9wcmlldGFyeTwvRk9OVD4gPC9QPg0KPERJVj4mbmJzcDs8
L0RJVj48L0JPRFk+PC9IVE1MPg0K

------_=_NextPart_001_01C539DC.85090028--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
