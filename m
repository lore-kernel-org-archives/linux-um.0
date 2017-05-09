Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1d804i-0007cO-GS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 08:00:52 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
	helo=www.kot-begemot.co.uk)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d804g-0006MN-B7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 08:00:52 +0000
Received: from tun5.smaug.kot-begemot.co.uk ([192.168.18.6]
	helo=smaug.kot-begemot.co.uk) by www.kot-begemot.co.uk with esmtps
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84_2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1d804Z-0008Hd-50
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 08:00:43 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84_2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1d804Y-0003hY-Tt
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 09:00:42 +0100
References: <27ae4e1c-7c6c-14c2-f3a4-9d0b1265d034@cambridgegreys.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <f615c3cf-02c5-a4ca-7b6a-eacb2f4edc49@kot-begemot.co.uk>
Date: Tue, 9 May 2017 09:00:41 +0100
MIME-Version: 1.0
In-Reply-To: <27ae4e1c-7c6c-14c2-f3a4-9d0b1265d034@cambridgegreys.com>
Subject: [uml-devel] Fwd: DQL and TCQ_F_CAN_BYPASS destroy performance under
 virtualizaiton (Was: "Re: net_sched strange in 4.11")
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7259739017385505184=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============7259739017385505184==
Content-Type: multipart/alternative;
	boundary="------------CDBB90B855D6BEC5C6FE862B"

This is a multi-part message in MIME format.
--------------CDBB90B855D6BEC5C6FE862B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Once I get some ideas on how to sort out THIS (forwarded) mess I will 
submit the vector drivers and the epoll controller they depend on.

I got the RX to > 1.7Gbit (for the reference, kvm on same machine just 
about manages 1.4 using tap). I cannot get TX done because of the 
wonderful bufferbloat optimizations in the recent kernels.

As usually, the glorious quest against too many buffers is doing more 
harm than good.

I can of course just #ifdef CONFIG_UML the relevant bits in the packet 
scheduler, but this is vandalism. We should not be doing it and it 
affects kvm as well.

A.



-------- Forwarded Message --------
Subject: 	DQL and TCQ_F_CAN_BYPASS destroy performance under 
virtualizaiton (Was: "Re: net_sched strange in 4.11")
Date: 	Tue, 9 May 2017 08:46:46 +0100
From: 	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: 	Cambridge Greys Limited
To: 	David S. Miller <davem@davemloft.net>
CC: 	netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>



I have figured it out. Two issues.

1) skb->xmit_more is hardly ever set under virtualization because the
qdisc is usually bypassed because of TCQ_F_CAN_BYPASS. Once
TCQ_F_CAN_BYPASS is set a virtual NIC driver is not likely see
skb->xmit_more (this answers my "how does this work at all" question).

2) If that flag is turned off (I patched sched_generic to turn it off in
pfifo_fast while testing), DQL keeps xmit_more from being set. If the
driver is not DQL enabled xmit_more is never ever set. If the driver is
DQL enabled the queue is adjusted to ensure xmit_more stops happening
within 10-15 xmit cycles.

That is plain *wrong* for virtual NICs - virtio, emulated NICs, etc.
There, the BIG cost is telling the hypervisor that it needs to "kick"
the packets. The cost of putting them into the vNIC buffers is
negligible. You want xmit_more to happen - it makes between 50% and 300%
(depending on vNIC design) difference. If there is no xmit_more the vNIC
will immediately "kick" the hypervisor and try to signal that  the
packet needs to move straight away (as for example in virtio_net).

In addition to that, the perceived line rate is proportional to this
cost, so I am not sure that the current dql math holds. In fact, I think
it does not - it is trying to adjust something which influences the
perceived line rate.

So - how do we turn BOTH bypass and DQL adjustment while under
virtualization and set them to be "always qdisc" + "always xmit_more
allowed"

A.

P.S. Cc-ing virtio maintainer

A.


On 08/05/17 08:15, Anton Ivanov wrote:
> Hi all,
>
> I was revising some of my old work for UML to prepare it for
> submission and I noticed that skb->xmit_more does not seem to be set
> any more.
>
> I traced the issue as far as net/sched/sched_generic.c
>
> try_bulk_dequeue_skb() is never invoked (the drivers I am working on
> are dql enabled so that is not the problem).
>
> More interestingly, if I put a breakpoint and debug output into
> dequeue_skb() around line 147 - right before the bulk: tag that skb
> there is always NULL. ???
>
> Similarly, debug in pfifo_fast_dequeue shows only NULLs being
> dequeued. Again - ???
>
> First and foremost, I apologize for the silly question, but how can
> this work at all? I see the skbs showing up at the driver level, why
> are NULLs being returned at qdisc dequeue and where do the skbs at the
> driver level come from?
>
> Second, where should I look to fix it?
>
> A.
>


-- 
Anton R. Ivanov

Cambridge Greys Limited, England company No 10273661
http://www.cambridgegreys.com/


--------------CDBB90B855D6BEC5C6FE862B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Once I get some ideas on how to sort out THIS (forwarded) mess I
      will submit the vector drivers and the epoll controller they
      depend on.<br>
    </p>
    <p>I got the RX to &gt; 1.7Gbit (for the reference, kvm on same
      machine just about manages 1.4 using tap). I cannot get TX done
      because of the wonderful bufferbloat optimizations in the recent
      kernels. <br>
    </p>
    <p>As usually, the glorious quest against too many buffers is doing
      more harm than good.</p>
    <p>I can of course just #ifdef CONFIG_UML the relevant bits in the
      packet scheduler, but this is vandalism. We should not be doing it
      and it affects kvm as well.<br>
    </p>
    <p>A.<br>
    </p>
    <div class="moz-forward-container"><br>
      <br>
      -------- Forwarded Message --------
      <table class="moz-email-headers-table" border="0" cellpadding="0"
        cellspacing="0">
        <tbody>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">Subject:
            </th>
            <td>DQL and TCQ_F_CAN_BYPASS destroy performance under
              virtualizaiton (Was: "Re: net_sched strange in 4.11")</td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">Date: </th>
            <td>Tue, 9 May 2017 08:46:46 +0100</td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">From: </th>
            <td>Anton Ivanov <a class="moz-txt-link-rfc2396E" href="mailto:anton.ivanov@cambridgegreys.com">&lt;anton.ivanov@cambridgegreys.com&gt;</a></td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">Organization:
            </th>
            <td>Cambridge Greys Limited</td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">To: </th>
            <td>David S. Miller <a class="moz-txt-link-rfc2396E" href="mailto:davem@davemloft.net">&lt;davem@davemloft.net&gt;</a></td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">CC: </th>
            <td><a class="moz-txt-link-abbreviated" href="mailto:netdev@vger.kernel.org">netdev@vger.kernel.org</a>, Stefan Hajnoczi
              <a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      <pre>I have figured it out. Two issues.

1) skb-&gt;xmit_more is hardly ever set under virtualization because the 
qdisc is usually bypassed because of TCQ_F_CAN_BYPASS. Once 
TCQ_F_CAN_BYPASS is set a virtual NIC driver is not likely see 
skb-&gt;xmit_more (this answers my "how does this work at all" question).

2) If that flag is turned off (I patched sched_generic to turn it off in 
pfifo_fast while testing), DQL keeps xmit_more from being set. If the 
driver is not DQL enabled xmit_more is never ever set. If the driver is 
DQL enabled the queue is adjusted to ensure xmit_more stops happening 
within 10-15 xmit cycles.

That is plain *wrong* for virtual NICs - virtio, emulated NICs, etc. 
There, the BIG cost is telling the hypervisor that it needs to "kick" 
the packets. The cost of putting them into the vNIC buffers is 
negligible. You want xmit_more to happen - it makes between 50% and 300% 
(depending on vNIC design) difference. If there is no xmit_more the vNIC 
will immediately "kick" the hypervisor and try to signal that  the 
packet needs to move straight away (as for example in virtio_net).

In addition to that, the perceived line rate is proportional to this 
cost, so I am not sure that the current dql math holds. In fact, I think 
it does not - it is trying to adjust something which influences the 
perceived line rate.

So - how do we turn BOTH bypass and DQL adjustment while under 
virtualization and set them to be "always qdisc" + "always xmit_more 
allowed"

A.

P.S. Cc-ing virtio maintainer

A.


On 08/05/17 08:15, Anton Ivanov wrote:
&gt; Hi all,
&gt;
&gt; I was revising some of my old work for UML to prepare it for 
&gt; submission and I noticed that skb-&gt;xmit_more does not seem to be set 
&gt; any more.
&gt;
&gt; I traced the issue as far as net/sched/sched_generic.c
&gt;
&gt; try_bulk_dequeue_skb() is never invoked (the drivers I am working on 
&gt; are dql enabled so that is not the problem).
&gt;
&gt; More interestingly, if I put a breakpoint and debug output into 
&gt; dequeue_skb() around line 147 - right before the bulk: tag that skb 
&gt; there is always NULL. ???
&gt;
&gt; Similarly, debug in pfifo_fast_dequeue shows only NULLs being 
&gt; dequeued. Again - ???
&gt;
&gt; First and foremost, I apologize for the silly question, but how can 
&gt; this work at all? I see the skbs showing up at the driver level, why 
&gt; are NULLs being returned at qdisc dequeue and where do the skbs at the 
&gt; driver level come from?
&gt;
&gt; Second, where should I look to fix it?
&gt;
&gt; A.
&gt;


-- 
Anton R. Ivanov

Cambridge Greys Limited, England company No 10273661
<a class="moz-txt-link-freetext" href="http://www.cambridgegreys.com/">http://www.cambridgegreys.com/</a>

</pre>
    </div>
  </body>
</html>

--------------CDBB90B855D6BEC5C6FE862B--


--===============7259739017385505184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============7259739017385505184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7259739017385505184==--


