Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8A4Y-00006J-VX for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2005 20:42:26 -0800
Received: from bay24-f21.bay24.hotmail.com ([64.4.18.71] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8A4X-0000ua-Fl for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2005 20:42:26 -0800
Message-ID: <BAY24-F21573D60D3DDE776FDC27C835F0@phx.gbl>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_6243_72fd_3c69"
Subject: [uml-devel] RE: uml_switch security fixing
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
Date: Mon, 07 Mar 2005 04:42:19 +0000
To: blaisorblade@yahoo.it, kraxel@bytesex.org
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_6243_72fd_3c69
Content-Type: text/plain; format=flowed

Blaisorblade wrote:
>Hey, has anyone found the time to put together any patch to workaround the
>security bug in uml_net?

Attached are two patches.  The first one, uml_net-slip.diff, is the minimal 
patch to apply to uml_net.  The second one, uml_net-uml.diff, applies to 
2.4.27-1um (note the half-hearted attempt to plug a FD leak in there as 
well).  As a nice bonus, a UML with this patch still works with an unpatched 
uml_net binary.

>I think it would be ok also to simply comment out the offending code (even
>providing some kind of -D configuration option for who really needs SLIP
>support, and they are few)!
>
>Suggestions?

Agreed, tuntap is a compile time option, slip should be as well.

Steve Schmidtke


------=_NextPart_000_6243_72fd_3c69
Content-Type: application/octet-stream; name="uml_net-slip.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="uml_net-slip.diff"

LS0tIHRvb2xzLTIwMDQwNDA2Lm9sZC91bWxfbmV0L3NsaXAuYwkyMDAyLTA0
LTI4IDE1OjQ3OjM1LjAwMDAwMDAwMCAtMDQwMAorKysgdG9vbHMtMjAwNDA0
MDYubmV3L3VtbF9uZXQvc2xpcC5jCTIwMDUtMDMtMDcgMTA6NDA6MzcuMDAw
MDAwMDAwIC0wNTAwCkBAIC0xMTEsNyArMTExLDcgQEAKIHZvaWQgc2xpcF92
NChpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiB7CiAgIHN0cnVjdCBvdXRwdXQg
b3V0cHV0ID0gSU5JVF9PVVRQVVQ7Ci0gIGNoYXIgKm9wOworICBjaGFyICpv
cCwgZGV2W3NpemVvZigic2xubm5ublwwIildOwogCiAgIGlmKHNldHJldWlk
KDAsIDApIDwgMCl7CiAgICAgb3V0cHV0X2Vycm5vKCZvdXRwdXQsICJzbGlw
IC0gc2V0cmV1aWQgZmFpbGVkIik7CkBAIC0xMzUsNyArMTM1LDggQEAKICAg
ICBzbGlwX3VwKDAsIGFyZ3ZbMV0sIE5VTEwsIE5VTEwsICZvdXRwdXQpOwog
ICB9CiAgIGVsc2UgaWYoIXN0cmNtcChvcCwgImRvd24iKSl7Ci0gICAgc2xp
cF9kb3duKGFyZ3ZbMV0sIE5VTEwsIE5VTEwsICZvdXRwdXQpOworICAgIHNs
aXBfbmFtZSgwLCBkZXYsICZvdXRwdXQpOworICAgIHNsaXBfZG93bihkZXYs
IE5VTEwsIE5VTEwsICZvdXRwdXQpOwogICB9CiAgIGVsc2UgewogICAgIHBy
aW50Zigic2xpcCAtIFVua25vd24gb3AgJyVzJ1xuIiwgb3ApOwo=


------=_NextPart_000_6243_72fd_3c69
Content-Type: application/octet-stream; name="uml_net-uml.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="uml_net-uml.diff"

LS0tIGxpbnV4LTIuNC4yNy0xdW0ub2xkL2FyY2gvdW0vZHJpdmVycy9zbGlw
X3VzZXIuYwkyMDA1LTAzLTA3IDA5OjU5OjE0LjAwMDAwMDAwMCAtMDUwMAor
KysgbGludXgtMi40LjI3LTF1bS5uZXcvYXJjaC91bS9kcml2ZXJzL3NsaXBf
dXNlci5jCTIwMDUtMDMtMDcgMTE6NTU6MjUuMDAwMDAwMDAwIC0wNTAwCkBA
IC0xMDgsNiArMTA4LDkgQEAKIAkJCWVyciA9IC1FSU5WQUw7CiAJCX0KIAl9
CisKKwlvc19jbG9zZV9maWxlKGZkc1swXSk7CisKIAlyZXR1cm4oZXJyKTsK
IH0KIApAQCAtMTI4LDYgKzEzMSw3IEBACiAJc2ZkID0gb3Nfb3Blbl9maWxl
KHB0c25hbWUobWZkKSwgb2ZfcmR3cihPUEVORkxBR1MoKSksIDApOwogCWlm
KHNmZCA8IDApewogCQlwcmludGsoIkNvdWxkbid0IG9wZW4gdHR5IGZvciBz
bGlwIGxpbmUsIGVyciA9ICVkXG4iLCAtc2ZkKTsKKwkJb3NfY2xvc2VfZmls
ZShtZmQpOwogCQlyZXR1cm4oc2ZkKTsKIAl9CiAJaWYoc2V0X3VwX3R0eShz
ZmQpKSByZXR1cm4oLTEpOwpAQCAtMTc1LDcgKzE3OSw3IEBACiAKIAlzcHJp
bnRmKHZlcnNpb25fYnVmLCAiJWQiLCBVTUxfTkVUX1ZFUlNJT04pOwogCi0J
ZXJyID0gc2xpcF90cmFtcChhcmd2LCAtMSk7CisJZXJyID0gc2xpcF90cmFt
cChhcmd2LCBwcmktPnNsYXZlKTsKIAogCWlmKGVyciAhPSAwKQogCQlwcmlu
dGsoInNsaXBfdHJhbXAgZmFpbGVkIC0gZXJybm8gPSAlZFxuIiwgLWVycik7
Cg==


------=_NextPart_000_6243_72fd_3c69--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
