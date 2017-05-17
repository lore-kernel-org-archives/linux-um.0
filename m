Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dAuRH-0006UG-SC
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2017 08:36:11 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dAuRE-0001p6-3g
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2017 08:36:11 +0000
References: <131837db-75e3-f78f-6aae-6b7be8d051a8@m3y3r.de>
	<20170517105216.3f0e66817ed5b84cfc68dcb7@kernel.org>
Mime-Version: 1.0 (1.0)
In-Reply-To: <20170517105216.3f0e66817ed5b84cfc68dcb7@kernel.org>
Message-Id: <088BF58C-CB46-401C-8ECA-29AA0E6A3666@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Wed, 17 May 2017 10:35:59 +0200
Subject: Re: [uml-devel] [RFC PATCH 1/7] um: Use printk instead of printf in
	make_uml_dir
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5769166210411733910=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>


--===============5769166210411733910==
Content-Type: multipart/signed; micalg=sha1;
	boundary=Apple-Mail-04B43D0B-F6D5-4656-A54C-BCB617F9CDE8;
	protocol="application/pkcs7-signature"
Content-Transfer-Encoding: 7bit


--Apple-Mail-04B43D0B-F6D5-4656-A54C-BCB617F9CDE8
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit


> Am 17.05.2017 um 03:52 schrieb Masami Hiramatsu <mhiramat@kernel.org>:
> 
> Hi Thomas,

Hi,

> 
> On Tue, 16 May 2017 17:46:47 +0200
> Thomas Meyer <thomas@m3y3r.de> wrote:
> 
>> Hi,
>> 
>> as far as I understand everything under os-Linux should be OS specific 
>> and shouldn't rely on kernel functions.
> 
> I see, but umid.c already uses many printk()s. So that policy
> is not so clear now. For example, without this series,

Yes you are right. I did write nonsense!

I'm fine with all patches in series. Looks good to me!

> 
> $ grep printk -rw arch/um/os-Linux/ | wc -l
> 159
> 
> Thank you,
> 
>> 
>> @Richard: What do you think about this patch?
>> 
>> See: https://marc.info/?l=linux-kernel&m=149337493432407&w=2
>> 
>> with kind regards
>> thomas
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

--Apple-Mail-04B43D0B-F6D5-4656-A54C-BCB617F9CDE8
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s
Content-Transfer-Encoding: base64

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
PeLMnEm7tRjvT6lNp81SDvaRGPbrU4BZ1k/FGHiV+XitX0bypL12DS64bKo8OEgN4IMYYg3dXg9u
+gpn0rc8/l7AUrKUk0IlcvKrnvhNpxQ3xWxr7YeYANUny6Z5XVgLAkgaLmbF6J7Dl1VuAxjTve2S
1k2PNUQ/dnJmNCCR/bjjqTW69An093a5Z7/zrgunfPWQCNXtTtfKkQlPSVplOasg1m47e7uBj4bF
dNvBwZ641Aev4xEKqg9WMMK3Vy03LmbZa0IK48Vg1FP4XDmZeqBRKAooVbb5iQIDAQABo4IBbTCC
AWkwGgYDVR0RBBMwEYEPdGhvbWFzQG0zeTNyLmRlMA4GA1UdDwEB/wQEAwIGwDATBgNVHSUEDDAK
BggrBgEFBQcDBDBCBgNVHR8EOzA5MDegNaAzhjFodHRwOi8vdm9sa3N2ZXJzY2hsdWVzc2VsdW5n
LmRlL2NybC9wcml2YXRlY2EuY3JsMH4GCCsGAQUFBwEBBHIwcDA8BggrBgEFBQcwAoYwaHR0cDov
L3ZvbGtzdmVyc2NobHVlc3NlbHVuZy5kZS9jYS9wcml2YXRlY2EuY3J0MDAGCCsGAQUFBzABhiRo
dHRwOi8vb2NzcC52b2xrc3ZlcnNjaGx1ZXNzZWx1bmcuZGUwFAYDVR0gBA0wCzAJBgcrJA8JAQEB
MB0GA1UdDgQWBBQ6nNQ4hduFPYI2tI0+IcC/wTZSSDAMBgNVHRMBAf8EAjAAMB8GA1UdIwQYMBaA
FEJzCOU+QLR+x4VXEHf9EQ9FhKfdMA0GCSqGSIb3DQEBCwUAA4ICAQCDrepf05Bm93sh+Db4Vgee
W2GweWJDGhHj1vuWowuaXoRgSz0G+QQWs4OBljzU9e6/W63jFrXqCM495tS4LbpcRqNzvN8mVEuF
8mYw9ZM7YG9Nx+Y3Pt7IDrOgWpw8hmEFNAfb8/dTMaMDHkPGYqLOvJA2rgk8rK5eJ2cSZ3TFAc5Z
lz/Tq1PB59Jl/nzIabBo6x7tvhjiqSL/R0fg/oi9nRvevNrCEWe/JjBoOST51HWV/91PaasDLEG/
OFG1lWsy7m0kYx4mHgxlsRVznIE9V1IguNi+1bY2k44mRNscufUNgVezto4JBARIEuLhFgIXQ8Vv
5r0ynhpsDtIfuI/NejqUlenSNe99FssF0GOluZ6qovSLb+f5GcLhcEf8OV0tUaAhEryL5w7rh4Hq
ca1IZ1OxDkTNxgQVOr9qihZhQblH6HWYzi3C2nFvWdVqcQV+ZAppZqF7HD1A23FiFOter5V5CDy8
19dZc9Dwu0MowmVZiOlh2mhPk1ID2vCSGtM2KGq/ZnJH9gnjzN3B0WJg0dmVQdtggCgj4Caq7f4V
tY9K1oIIyIuo6mpjBk+LFtgI+kWdDpsU6fzEyq3PmTW/0/cYzI1kJvUztj+0AHNyCBij4F3Yf3mi
Ob88vCPJPZg6Rhry9hxwX13zHbEE6FfiWRcxWihkwFXmEckbUR5YFDCCBoIwggRqoAMCAQICCA7P
iiLFnseHMA0GCSqGSIb3DQEBCwUAME4xJjAkBgNVBAMMHVZvbGtzdmVyc2NobHVlc3NlbHVuZyBS
b290IENBMRcwFQYDVQQKDA5GcmF1bmhvZmVyIFNJVDELMAkGA1UEBhMCREUwHhcNMTYwNTA5MTQw
OTEzWhcNMjEwNTEwMTQwOTEzWjBRMSkwJwYDVQQDDCBWb2xrc3ZlcnNjaGx1ZXNzZWx1bmcgUHJp
dmF0ZSBDQTEXMBUGA1UECgwORnJhdW5ob2ZlciBTSVQxCzAJBgNVBAYTAkRFMIICIjANBgkqhkiG
9w0BAQEFAAOCAg8AMIICCgKCAgEAzNfyQJBPr3f99kqZCdW9r9U2EKFTXg6IuLh8LWKsZHo8XiRE
BarheOkdxdSKW9FTUEZUdwWk1uwpuDYnIfEcKrTAOiItrdRJc98h2yhD6tlZgSLY/B9Vjw2LQIZZ
WVnsYVvBOxYznfaveDY7HfowbXgERxv30sQqNZP+KhUB3JjQ1pVAVyLZxK+j8a7k1bFH955kkJ6G
+AoTzZzHj5Bn9LUTFvP7RsB2rNPy+GBZ52EvdlqrGEi7JKvM9M8jffA6RZ8OzXS1utng5jWj+efw
Hg5Wr4JC3YZs/TpNogPVyw4vDjCF/RI56mrSUQBXm1IVjuWM8qUhphBR2gRZN0sATWCj8pWG1pLl
Mz02Ddg/AbZ7V9C6MwH4I6nGQ1XxhNSkWSrUQUnXYrOoA8T0IH/6AuY7ukMrj+KLJtTlM1Y+sOXR
Zyk/QFSgVP/5AbT82ErsVZW1q7JDLkaEdwrPDFXQNqfrlIsYI3FYrgB6rVJG3tZ/3LMmFHNQVnTX
hCiy6mUFpogdAl1QxXeNMWAdVLMBBm/iY9IZwtqb9G/Gxt19QmHLpLwyo4nVX1F7Got+yLYzfrLf
0toMk3Kjj7uhlndhpkoeFwDKMioi1dsUn3zxRK6dwaPzkKsphj8ybXFBr3s68A4+xKmaQxR7gcg9
tPKB/pTyC8vtkAl1lfNU14IV2ikCAwEAAaOCAV8wggFbMEkGCCsGAQUFBwEBBD0wOzA5BggrBgEF
BQcwAoYtaHR0cDovL3ZvbGtzdmVyc2NobHVlc3NlbHVuZy5kZS9jYS9yb290Y2EuY3J0MB0GA1Ud
DgQWBBRCcwjlPkC0fseFVxB3/REPRYSn3TASBgNVHRMBAf8ECDAGAQH/AgEAMB8GA1UdIwQYMBaA
FBeNp8XO7dqGdP5+TYW2xuL7R78PMBEGA1UdIAQKMAgwBgYEVR0gADCBlgYDVR0fBIGOMIGLMIGI
oDKgMIYuaHR0cDovL3ZvbGtzdmVyc2NobHVlc3NlbHVuZy5kZS9jcmwvcm9vdGNhLmNybKJSpFAw
TjEmMCQGA1UEAwwdVm9sa3N2ZXJzY2hsdWVzc2VsdW5nIFJvb3QgQ0ExFzAVBgNVBAoMDkZyYXVu
aG9mZXIgU0lUMQswCQYDVQQGEwJERTAOBgNVHQ8BAf8EBAMCAQYwDQYJKoZIhvcNAQELBQADggIB
AFlX5ruAA0T3RL9Z+NQo7syDNwv3n1p1eSIloJlKGkIlHdNUJNxfjvzpLvm1n47sUsbHlZOW7MDK
P2ODo94i5yHKEB2TPQF4NMJBsiH60xQuFQDgKd5nawBOgs1hVJR0ijGlMipwrYwfdNvyrXCHGew0
PDuRcRa53VRR3vE1vxhHYpbyPOdq3s2Q+TfvF3ihr+WkvujnSQocg65bY/Tj4+ARjdt1odI4HzHw
gDPc3SfUPgOEedte23oU8Y2LRpKpb9eHeb0hH32hQ+QOToULISE42ymiG5MOi4hxKUUZrGIK+BQ9
r/dABOsbskFA7j7rL/k5+v2j73oLals47S1BRHsIU3pX7K5XfVnDTVu5vSlLCjEV+C9pqHv0pDB5
fhQb6ZImjWJfkFdvFry+EYbbpogMr+seUytfUmd+8cz05d1ncTUN926iiY6AGxSKCRvHbrtQdVFJ
IX4jlKIpnDg4DH9Xlatlr/K/zNAIxiiNXrQND+UmhEgf2Rb0Ba3whIc9moXGQEjZdrt4qLJjtccq
OcOgvNszFuFIvhzpdH69+twIZtM4fBP1AjVfRxRhhNmAzz701bcAGv2vRgYURHsQ+GoedTGnhgAi
WjwSoIkQlD7mjjB7/ayUWCCbQ4AW0/Wjja2B9ahRQkQwSn3F1eBeuXRHM5Jk54/yq6uT7rnZG93n
MYICwzCCAr8CAQEwXTBRMSkwJwYDVQQDDCBWb2xrc3ZlcnNjaGx1ZXNzZWx1bmcgUHJpdmF0ZSBD
QTEXMBUGA1UECgwORnJhdW5ob2ZlciBTSVQxCzAJBgNVBAYTAkRFAggSgbEVWeufUzAJBgUrDgMC
GgUAoIIBOzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNzA1MTcw
ODM1NTlaMCMGCSqGSIb3DQEJBDEWBBRZruX8k/TCyWa02+pls20/6o8qSzBsBgkrBgEEAYI3EAQx
XzBdMFExKTAnBgNVBAMMIFZvbGtzdmVyc2NobHVlc3NlbHVuZyBQcml2YXRlIENBMRcwFQYDVQQK
DA5GcmF1bmhvZmVyIFNJVDELMAkGA1UEBhMCREUCCBKBsRVZ659TMG4GCyqGSIb3DQEJEAILMV+g
XTBRMSkwJwYDVQQDDCBWb2xrc3ZlcnNjaGx1ZXNzZWx1bmcgUHJpdmF0ZSBDQTEXMBUGA1UECgwO
RnJhdW5ob2ZlciBTSVQxCzAJBgNVBAYTAkRFAggSgbEVWeufUzANBgkqhkiG9w0BAQEFAASCAQBq
9UHL7xAOe9M8RkHZLAo8XR5+NFB943CpMKw3Se6ou6BURUA4VT+r+mfn/JtauOOnhYJO9Vg1VJiK
yPF/jmuKzVTI1pQsq3EEjEByTqn1xDKpl6WnonEu7XUzxOncl9b86ViF8aJrmYivhjOCuERSgpgo
ULZjEOT7y31sY+KPj3W0GjmbYCC5jUx1cBpq1ATFhRzjakPPa7w5TanN5EHT5cexXDbNCwRFdK9F
1I+CEx90CZLYgmxjXoUApiJULijNaR5GeggN1kHl8VDnevBFqN/JVcKa14CAwoOAFWkHmkAxM958
YqaGLbAsvTNrVtlOdCRSPIlulITNwE67+qmcAAAAAAAA
--Apple-Mail-04B43D0B-F6D5-4656-A54C-BCB617F9CDE8--


--===============5769166210411733910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============5769166210411733910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5769166210411733910==--


