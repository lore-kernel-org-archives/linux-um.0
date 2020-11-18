Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfUrJ-0001cy-Bp
 for linux-um@lists.infradead.org; Wed, 18 Nov 2020 21:19:22 +0000
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] um: ubd: Submit all data segments atomically
References: <20201025044139.3019273-1-krisman@collabora.com>
 <7c1bf8c3-0e80-ab90-778c-c124fab3f747@cambridgegreys.com>
Date: Wed, 18 Nov 2020 16:19:11 -0500
In-Reply-To: <7c1bf8c3-0e80-ab90-778c-c124fab3f747@cambridgegreys.com> (Anton
 Ivanov's message of "Mon, 26 Oct 2020 09:25:51 +0000")
Message-ID: <87pn4atlbk.fsf@collabora.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Martyn Welch <martyn@collabora.com>, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>

Anton Ivanov <anton.ivanov@cambridgegreys.com> writes:

> On 25/10/2020 04:41, Gabriel Krisman Bertazi wrote:
>> Internally, UBD treats each physical IO segment as a separate command to
>> be submitted in the execution pipe.  If the pipe returns a transient
>> error after a few segments have already been written, UBD will tell the
>> block layer to requeue the request, but there is no way to reclaim the
>> segments already submitted.  When a new attempt to dispatch the request
>> is done, those segments already submitted will get duplicated, causing
>> the WARN_ON below in the best case, and potentially data corruption.
>> In my system, running a UML instance with 2GB of RAM and a 50M UBD
>> disk,

>>   [...]
>> ---[ end trace c6e7444e55386c0f ]---
>> Cc: Christopher Obbard <chris.obbard@collabora.com>
>> Reported-by: Martyn Welch <martyn@collabora.com>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Hi,

Is this queued somewhere?  I've been watching the linux-next branch of
rw's tree.  Is that the right tree?

Thanks,

-- 
Gabriel Krisman Bertazi

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

