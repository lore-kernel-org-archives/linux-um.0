Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1e2O98-0000vA-Py for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 11 Oct 2017 21:02:30 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1e2O94-0005ZI-Oz
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 11 Oct 2017 21:02:30 +0000
Received: from tun5.smaug.kot-begemot.co.uk ([192.168.18.6]
 helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.84_2) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1e2O8y-0004DH-D8 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 11 Oct 2017 21:02:20 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
 by smaug.kot-begemot.co.uk with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1e2O8y-0004Ov-3h
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 11 Oct 2017 22:02:20 +0100
References: <d6c1cda2-f7df-9132-304d-075c62d4d83d@kot-begemot.co.uk>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <4637aa74-4471-0411-2c38-4c5135fa507d@kot-begemot.co.uk>
Date: Wed, 11 Oct 2017 22:02:20 +0100
MIME-Version: 1.0
In-Reply-To: <d6c1cda2-f7df-9132-304d-075c62d4d83d@kot-begemot.co.uk>
Subject: [uml-devel] Fwd: Re: BUG:af_packet fails to TX TSO frames
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2121168029089664724=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============2121168029089664724==
Content-Type: multipart/alternative;
 boundary="------------A2B709AA2E7EB9851F683C48"

This is a multi-part message in MIME format.
--------------A2B709AA2E7EB9851F683C48
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

And that is the culprit of why GSO does not work with raw sockets.

There can be no workaround unfortunately, this simply will need to be
enabled in the driver once the kernel is fixed.

It should work for older kernels prior to the fix in comit104ba78c9880 too.

So from that perspective there is nothing that can be done to the vector
io drivers - the code is correct, it is the host kernel side which is
broken :(

A.

-------- Forwarded Message --------
Subject: 	Re: BUG:af_packet fails to TX TSO frames
Date: 	Wed, 11 Oct 2017 20:39:57 +0100
From: 	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
To: 	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: 	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Network Development
<netdev@vger.kernel.org>, David Miller <davem@davemloft.net>



On 11/10/17 19:57, Willem de Bruijn wrote:
> On Wed, Oct 11, 2017 at 2:39 PM, Anton Ivanov
> <anton.ivanov@kot-begemot.co.uk> wrote:
>> The check as now insists that the actual driver supports GSO_ROBUST, because
>> we have marked the skb dodgy.
>>
>> The specific bit which does this check is in net_gso_ok()
>>
>> Now, lets's see how many Ethernet drivers set GSO_ROBUST.
>>
>> find drivers/net/ethernet -type f -name "*.[c,h]" -exec grep -H GSO_ROBUST
>> {} \;
>>
>> That returns nothing in 4.x
>>
>> IMHO - af_packet allocates the skb, does all checks (and extra may be added)
>> on the gso, why is this set dodgy in the first place?
> It is set when the header has to be validated.
>
> The segmentation logic will validate and fixup gso_segs. See for
> instance tcp_gso_segment:
>
>         if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
>                 /* Packet is from an untrusted source, reset gso_segs. */
>
>                 skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len, mss);
>
>                 segs = NULL;
>                 goto out;
>         }
>
> If the device would have the robust bit set and otherwise supports the
> required features, fix up gso_segs and pass the large packet to the
> device.
>
> Else it continues to the software gso path.
>
> Large packets generated with psock_txring_vnet.c pass this test. I

That test is indeed a different path - this goes via the tpacket_snd
which allocs via sock_alloc_send_skb. That results in a non-fragged skb
as it calls pskb after that with data_len = 0 asking for a contiguous one.

My stuff is using sendmmsg which ends up via packet_snd which allocs
via  sock_alloc_send_pskb which is invoked in a way which always creates
2 segments - one for the linear section and one for the rest (and more
if needed). It is faster than tpacket by the way (several times).

As a comparison tap and other virtual drivers use sock_alloc_send_pskb
with non-zero data length which results in multiple frags. The code in
packet_snd is in fact identical with tap (+/- some cosmetic differences).

That is the difference between the tests and that is why your test works
and mine fails.

Now, alloc-ing a 64k contiguous skb every time IMHO is wrong.

So the logic in the xmit check at present works only because it is given
only a very corner case for a GSO frame and tested versus it. It should
work with the generic case which is what comes out of
sock_alloc_send_pskb (same as in tap).

A.



> suspect that there is a subtle difference in the virtio_net_hdr fields
> that that generates vs. your program.
>



--------------A2B709AA2E7EB9851F683C48
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    And that is the culprit of why GSO does not work with raw sockets.<br>
    <br>
    There can be no workaround unfortunately, this simply will need to
    be enabled in the driver once the kernel is fixed. <br>
    <br>
    It should work for older kernels prior to the fix in
    comit104ba78c9880 too.<br>
    <br>
    So from that perspective there is nothing that can be done to the
    vector io drivers - the code is correct, it is the host kernel side
    which is broken :(<br>
    <br>
    A.<br>
    <div class="moz-forward-container"><br>
      -------- Forwarded Message --------
      <table class="moz-email-headers-table" border="0" cellpadding="0"
        cellspacing="0">
        <tbody>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">Subject:
            </th>
            <td>Re: BUG:af_packet fails to TX TSO frames</td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">Date: </th>
            <td>Wed, 11 Oct 2017 20:39:57 +0100</td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">From: </th>
            <td>Anton Ivanov <a class="moz-txt-link-rfc2396E" href="mailto:anton.ivanov@kot-begemot.co.uk">&lt;anton.ivanov@kot-begemot.co.uk&gt;</a></td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">To: </th>
            <td>Willem de Bruijn <a class="moz-txt-link-rfc2396E" href="mailto:willemdebruijn.kernel@gmail.com">&lt;willemdebruijn.kernel@gmail.com&gt;</a></td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">CC: </th>
            <td>Anton Ivanov <a class="moz-txt-link-rfc2396E" href="mailto:anton.ivanov@cambridgegreys.com">&lt;anton.ivanov@cambridgegreys.com&gt;</a>,
              Network Development <a class="moz-txt-link-rfc2396E" href="mailto:netdev@vger.kernel.org">&lt;netdev@vger.kernel.org&gt;</a>, David
              Miller <a class="moz-txt-link-rfc2396E" href="mailto:davem@davemloft.net">&lt;davem@davemloft.net&gt;</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      <pre>On 11/10/17 19:57, Willem de Bruijn wrote:
&gt; On Wed, Oct 11, 2017 at 2:39 PM, Anton Ivanov
&gt; <a class="moz-txt-link-rfc2396E" href="mailto:anton.ivanov@kot-begemot.co.uk">&lt;anton.ivanov@kot-begemot.co.uk&gt;</a> wrote:
&gt;&gt; The check as now insists that the actual driver supports GSO_ROBUST, because
&gt;&gt; we have marked the skb dodgy.
&gt;&gt;
&gt;&gt; The specific bit which does this check is in net_gso_ok()
&gt;&gt;
&gt;&gt; Now, lets's see how many Ethernet drivers set GSO_ROBUST.
&gt;&gt;
&gt;&gt; find drivers/net/ethernet -type f -name "*.[c,h]" -exec grep -H GSO_ROBUST
&gt;&gt; {} \;
&gt;&gt;
&gt;&gt; That returns nothing in 4.x
&gt;&gt;
&gt;&gt; IMHO - af_packet allocates the skb, does all checks (and extra may be added)
&gt;&gt; on the gso, why is this set dodgy in the first place?
&gt; It is set when the header has to be validated.
&gt;
&gt; The segmentation logic will validate and fixup gso_segs. See for
&gt; instance tcp_gso_segment:
&gt;
&gt;         if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
&gt;                 /* Packet is from an untrusted source, reset gso_segs. */
&gt;
&gt;                 skb_shinfo(skb)-&gt;gso_segs = DIV_ROUND_UP(skb-&gt;len, mss);
&gt;
&gt;                 segs = NULL;
&gt;                 goto out;
&gt;         }
&gt;
&gt; If the device would have the robust bit set and otherwise supports the
&gt; required features, fix up gso_segs and pass the large packet to the
&gt; device.
&gt;
&gt; Else it continues to the software gso path.
&gt;
&gt; Large packets generated with psock_txring_vnet.c pass this test. I

That test is indeed a different path - this goes via the tpacket_snd
which allocs via sock_alloc_send_skb. That results in a non-fragged skb
as it calls pskb after that with data_len = 0 asking for a contiguous one.

My stuff is using sendmmsg which ends up via packet_snd which allocs
via  sock_alloc_send_pskb which is invoked in a way which always creates
2 segments - one for the linear section and one for the rest (and more
if needed). It is faster than tpacket by the way (several times).

As a comparison tap and other virtual drivers use sock_alloc_send_pskb
with non-zero data length which results in multiple frags. The code in
packet_snd is in fact identical with tap (+/- some cosmetic differences).

That is the difference between the tests and that is why your test works
and mine fails.

Now, alloc-ing a 64k contiguous skb every time IMHO is wrong.

So the logic in the xmit check at present works only because it is given
only a very corner case for a GSO frame and tested versus it. It should
work with the generic case which is what comes out of
sock_alloc_send_pskb (same as in tap).

A.



&gt; suspect that there is a subtle difference in the virtio_net_hdr fields
&gt; that that generates vs. your program.
&gt;


</pre>
    </div>
  </body>
</html>

--------------A2B709AA2E7EB9851F683C48--


--===============2121168029089664724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============2121168029089664724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2121168029089664724==--


